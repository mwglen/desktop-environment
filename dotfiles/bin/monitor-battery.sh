#!/bin/bash

# Notify-send function
function notify-send() {
    #Detect the name of the display in use
    local display=":$(ls /tmp/.X11-unix/* | sed 's#/tmp/.X11-unix/X##' | head -n 1)"

    #Detect the user using such display
    local user=$(who | grep '('$display')' | awk '{print $1}' | head -n 1)

    #Detect the id of the user
    local uid=$(id -u $user)

    sudo -u $user DISPLAY=$display DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$uid/bus notify-send "$@"
}

# Read State
source /run/monitor-battery || true

# Parse Battery Info from ACPI
acpi -b | awk -F'[,:%]' '{print $2, $3}' | {
    
    # Get Battery Info
    read -r status capacity
    
    # Handle Battery When Discharging
    if [ "$status" = Discharging ]; then
        
        # Hibernate if Battery is Less Than 15%
        if [ "$capacity" -lt 15 ]; then
            # Log Hibernation
            logger "Hibernating due to critical battery level"

            # Clear Flags
            echo "" > /run/monitor-battery
            
            # Hibernate
            systemctl hibernate
            
        # Send Critical Warning is Less Than 20%
        elif [ "$capacity" -lt 20 ] && [ -z $CritWarningSent ]; then
            # Log Warning
            logger "Battery level critical"
            
            # Send Warning
            notify-send -u critical -i battery-level-0-symbolic -h string:x-dunst-stack-tag:crit-battery "Battery Critical"
            
            # Set Flag
            echo "CritWarningSent=true" > /run/monitor-battery
            
        # Send Warning if Battery is Less Than 30%
        elif [ "$capacity" -lt 30 ] && [ -z $LowWarningSent ]; then
            # Log Warning
            logger "Battery level low"
            
            # Send Warning
            notify-send -i battery-level-10-symbolic -t 10000 -h string:x-dunst-stack-tag:low-battery "Battery Low"
            
            # Set Flag
            echo "LowWarningSent=true" > /run/monitor-battery
        fi

    else
        
        # Clear Flags
        echo "" > /run/monitor-battery
        
    fi
    
}
