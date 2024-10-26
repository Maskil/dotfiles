#!/bin/bash

declare -a devices=(XHC0 PTXH GP12 GP13 GPP0 GPP8)
for device in "${devices[@]}"; do
    if grep -qw ^$device.*enabled /proc/acpi/wakeup; then
        sudo sh -c "echo $device > /proc/acpi/wakeup"
    fi
done
