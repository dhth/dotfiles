#!/bin/sh

charging_status() {
    if [ $(ioreg -r -n AppleSmartBattery | grep IsCharging | cut -c22-) == "Yes" ]; then
        echo "$(pmset -g batt | xargs | sed 's/.*) \([^ ]*\)%.*/\1%/') (c)"
    else
        echo "$(pmset -g batt | xargs | sed 's/.*) \([^ ]*\)%.*/\1%/')"
    fi
}

charging_status
