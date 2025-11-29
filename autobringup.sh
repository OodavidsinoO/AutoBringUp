#!/bin/bash
# Copyright (C) 2025 OodavidsinoO
# Credit to original script by Broly
# License: GNU General Public License v3.0
# https://www.gnu.org/licenses/gpl-3.0.txt

# Common device configurations
declare -A DEVICES=(
    ["Oneplus8T"]="device/oneplus/kebab:device/oneplus/sm8250-common:kebab"
    ["MotoG6"]="device/motorola/ali:device/motorola/msm8953-common:ali"
)

# Common bringup function
bringup_device() {
    local device_name="$1"
    local device_config="$2"
    
    IFS=':' read -r device_path common_path device_suffix <<< "$device_config"
    
    clear
    cat << "EOF"
#####################
#    AUTOBRINGUP    #
#####################
EOF
    printf "\n\n"
    printf "WARNING MAKE SURE TO ENTER THE CORRECT ROM NAME\n OR IT WILL RENAME SOME FILES WRONGLY!!!\n\n"
    read -r -p "Please enter the name of the old rom: " oldrom
    read -r -p "Now please enter the name of the new rom: " newrom
    printf "\n\n"
    
    # Process device-specific directory
    if [[ -d "$device_path" ]]; then
        cd "$device_path" || exit 1
    else
        printf "Path to device doesn't exist: %s\n" "$device_path"
        exit 1
    fi

    # Handle .dependencies file in device directory
    if [[ -f "$oldrom.dependencies" ]]; then
        mv "$oldrom.dependencies" "$newrom.dependencies" || :
    else
        printf "No .dependencies file in %s, ignoring\n" "$device_path"
    fi

    # Handle device makefile
    local device_mk="${oldrom}_${device_suffix}.mk"
    if [[ -f "$device_mk" ]]; then
        mv "$device_mk" "${newrom}_${device_suffix}.mk"
        sed -i "s/$oldrom/$newrom/g" ./*.*
        cd ../../../
    else
        printf "Device makefile not found: %s\n" "$device_mk"
        printf "Please make sure your device tree is correct!\n"
        exit 1
    fi

    # Process common device directory
    if [[ -d "$common_path" ]]; then
        cd "$common_path" || exit 1
    else
        printf "Path to common device doesn't exist: %s\n" "$common_path"
        exit 1
    fi

    # Handle .dependencies file in common directory
    if [[ -f "$oldrom.dependencies" ]]; then
        mv "$oldrom.dependencies" "$newrom.dependencies" || :
        sed -i "s/$oldrom/$newrom/g" ./*.*
        cd ../../../
    else
        printf "No .dependencies file in %s, ignoring\n" "$common_path"
    fi

    printf "\n\n"
    printf "Your bringup is finished!\n"
    printf "To start type:\n  source build/envsetup.sh\n  lunch\n"
}

# Custom device function
custom_device() {
    clear
    cat << "EOF"
#####################
#    AUTOBRINGUP    #
#####################
EOF
    printf "\n\n"
    printf "Custom Device Configuration\n"
    printf "===========================\n\n"
    printf "Enter the device paths in format: device_path:common_path:device_suffix\n"
    printf "Example: device/xiaomi/fuxi:device/xiaomi/sm8550-common:fuxi\n\n"
    
    read -r -p "Device configuration: " custom_config
    
    # Validate the custom configuration format
    if [[ "$custom_config" =~ ^[^:]+:[^:]+:[^:]+$ ]]; then
        bringup_device "Custom Device" "$custom_config"
    else
        printf "Invalid format! Please use device_path:common_path:device_suffix format.\n"
        printf "Example: device/xiaomi/fuxi:device/xiaomi/sm8550-common:fuxi\n"
        exit 1
    fi
}

# Device-specific functions (maintained for backward compatibility)
oneplus8t() {
    bringup_device "Oneplus8T" "${DEVICES[Oneplus8T]}"
}

motog6() {
    bringup_device "MotoG6" "${DEVICES[MotoG6]}"
}

# Main menu
PS3="Select your device please: "

select device in "${!DEVICES[@]}" "Custom" "Quit"
do
    case $device in
        "Oneplus8T"|"MotoG6")
            bringup_device "$device" "${DEVICES[$device]}"
            break
            ;;
        "Custom")
            custom_device
            break
            ;;
        "Quit")
            echo "Goodbye!"
            break
            ;;
        *)
            echo "Invalid selection. Please try again."
            ;;
    esac
done