#!/bin/bash

# --- Configuration and Variables ---
LOGS_FOLDER="var/log/shell-script"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

# Use 'basename' to get the clean script name, avoiding the path issue with 'cut'
# If you insist on cut, the best simple option is:
SCRIPT_NAME=$(basename "$0" | cut -d "." -f1)

LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"

# Color Codes
R="\e[31m" # Red
G="\e[32m" # Green
N="\e[0m"  # No Color

# Create log directory
mkdir -p "$LOGS_FOLDER"

# Function to Validate the previous command's exit status
VALIDATE(){
    # $1: Description of the task being validated
    # $2: Optional reason for failure
    
    # Check the exit status of the MOST RECENT command ($?)
    if [ $? -ne 0 ]; then
        # Log failure with the correct variable reference and print to screen
        echo -e "[$TIMESTAMP] $1 is $R failed $N" | tee -a "$LOG_FILE"
        echo "Reason: $2" | tee -a "$LOG_FILE"
        # Optional: exit script on critical failure
        # exit 1 
    else
        # Log success and print to screen
        echo -e "[$TIMESTAMP] $1 is $G success $N" | tee -a "$LOG_FILE"
    fi
}
# --- Initial Checks ---

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo -e "${R}ERROR:${N} Please run this script with root privileges (sudo)." | tee -a "$LOG_FILE"
    exit 1
fi

# Log start of script
echo "[$TIMESTAMP] Script $SCRIPT_NAME started." | tee -a "$LOG_FILE"

# --- Install Packages from Arguments ($@) ---
echo "[$TIMESTAMP] Checking for requested packages: $@" | tee -a "$LOG_FILE"

for package in "$@"; do
    # 1. Check if the package is installed using 'rpm -q' (more reliable than dnf list)
    rpm -q "$package"
    
    if [ $? -ne 0 ]; then
        echo "[$TIMESTAMP] Package '$package' is not installed. Attempting installation..." | tee -a "$LOG_FILE"
        # 2. Install the package
        dnf install "$package" -y &>> "$LOG_FILE" # Redirect DNF output to log only
        # 3. Validate the DNF install command
        VALIDATE "Installation of $package" "dnf install command failed."
    else  
        echo -e "[$TIMESTAMP] $G $package already installed. Enjoy! $N" | tee -a "$LOG_FILE"
    fi
done

# --- Install Specific Package (git) ---
echo "[$TIMESTAMP] Checking for specific package: git" | tee -a "$LOG_FILE"

rpm -q git
if [ $? -ne 0 ]; then
    echo "[$TIMESTAMP] Package 'git' is not installed. Attempting installation..." | tee -a "$LOG_FILE"
    dnf install git -y &>> "$LOG_FILE"
    VALIDATE "Installation of git" "dnf install command failed."
else  
    echo -e "[$TIMESTAMP] $G git already installed. Enjoy! $N" | tee -a "$LOG_FILE"
fi

echo "[$TIMESTAMP] Script finished." | tee -a "$LOG_FILE"