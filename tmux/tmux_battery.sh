#!/bin/sh

charging_status()
{
    if [ $(ioreg -r -n AppleSmartBattery | grep IsCharging | cut -c22-) == "Yes" ]; then
        echo "$(pmset -g batt |xargs | sed 's/.*) \([^ ]*\)%.*/\1%/')"
    else
        echo "$(pmset -g batt |xargs | sed 's/.*) \([^ ]*\)%.*/\1%/') (d)"
    fi
}

charging_status
