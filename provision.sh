#!/usr/bin/env bash

# Version number: 1.0.0
# Script written by author: https://github.com/atenatt
# Script reviewed in 11/06/2024
# Author contact: victor.boas@fatec.sp.gov.br

# Variables
DIR_LOG="/vagrant/logs" 
LOG_FILE_NAME="provision.log"
ARQ_LOG="$DIR_LOG/$LOG_FILE_NAME"
LOG_INIT_MSG="$DATE $USER: [$?]"
WEBSERVER="apache2"
REPOSITORY="https://github.com/KelvinSCandido/Mundo-Invertido-.git"

log_register() {
    DATE=$(date +'%d/%m/%Y %H:%M')
    if [ $? -eq 0 ]; then
        echo "$LOG_INIT_MSG $1" >> "$ARQ_LOG"
    else
        echo "$LOG_INIT_MSG $2" >> "$ARQ_LOG"
    fi
}

check_directory() {
    if [ -d "$DIR_LOG" ]; then
        log_register "The log directory $DIR_LOG already exists."
        rm -rf $DIR_LOG/*
    else
        log_register "The log directory $DIR_LOG doesn't exist, we'll try to create it for you"
        if mkdir -p "$DIR_LOG" >/dev/null 2>&1; then
            log_register "The log directory $DIR_LOG has been created"
        elif sudo mkdir -p "$DIR_LOG" >/dev/null 2>&1; then
            log_register "The log directory $DIR_LOG has been created with sudo permissions"
        else
            log_register "Failed to create the log directory $DIR_LOG, please contact your system administrator."
        fi
    fi
}

# Function to update the system packages
systemupdate() {
    log_register "Updating the system"
    apt update -y >/dev/null 2>&1
        log_register "System updated successfully" "Failed to update the system"
}

# Function to install webserver packages
install_webserver(){
    echo "$LOG_INIT_MSG Installing the Webserver ($WEBSERVER)" >> "$ARQ_LOG"
    apt install -y $WEBSERVER >/dev/null 2>&1
    log_register "$WEBSERVER was installed with success" "$WEBSERVER not was installed, please, verify.."
}

# Function to install git packages
install_git(){
    echo "$LOG_INIT_MSG Installing the git package" >> "$ARQ_LOG"
    apt install -y git >/dev/null 2>&1
    log_register "git was installed with sucess" "git not was installed, please verify.."
}

# Function to clone remote repository
cloning_repository(){
    echo "$LOG_INIT_MSG Cloning the remote repository" >> "$ARQ_LOG"
    git clone $REPOSITORY >/dev/null 2>&1

    nome_repo=$(basename "$REPOSITORY" .git)
    nome_repo=${nome_repo##/}    

    if [ -d "$nome_repo" ]; then
        echo "$LOG_INIT_MSG Repository download successfully performed" >> "$ARQ_LOG"
        cp -r "$nome_repo"/* /var/www/html >/dev/null 2>&1
        log_register "The repository has been copied to the /var/www/html folder" ""
    else
        log_register "" "The repository not cloned, please verify..."
    fi
}

# Function to start Apache server
start_apache(){
    echo "$LOG_INIT_MSG Starting the webserver service" >> "$ARQ_LOG"
    service $WEBSERVER start >/dev/null 2>&1
    log_register "The webserver has been started successfully" "The webserver was not started successfully, please verify..."
}

# Function to show script completion message
msg_finish(){
    echo "$LOG_INIT_MSG End of execution of the provisioning script." >> "$ARQ_LOG"
    cat << EOF 
        End of script execution, check the logs in $ARQ_LOG
        You can access the website URL: localhost:8001
EOF
}

# Main function to execute the script
main(){
    check_directory
    systemupdate
    install_webserver
    install_git
    cloning_repository
    start_apache
    msg_finish
}

main  # Calling the main function to start the script execution
