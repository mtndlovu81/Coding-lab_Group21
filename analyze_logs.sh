#!/bin/bash

# --- Interactive Menu ---
echo "Select log file to analyze:"
echo "1) Heart Rate (heart_rate.log)"
echo "2) Temperature (temperature.log)"
echo "3) Water Usage (water_usage.log)"
read -p "Enter choice (1-3): " choice

# --- Input Validation ---
if [ "$choice" = "1" ]; then
    logfile="heart_rate.log"
elif [ "$choice" = "2" ]; then
    logfile="temperature.log"
elif [ "$choice" = "3" ]; then
    logfile="water_usage.log"
else
    echo "Invalid choice, please enter 1, 2, or 3."
    exit 1
fi

# Check if log file exists
if [ ! -f "$logfile" ]; then
    echo "Log file '$logfile' not found!"
    exit 1
fi

echo "Analyzing $logfile ..."

# --- Analysis ---
# Assuming log format: "timestamp device_name value"
# Example line: 2026-02-01T08:00:00 Device1 72

# Get unique devices
devices=$(awk '{print $2}' "$logfile" | sort | uniq)

for device in $devices; do
    # Count occurrences
    count=$(grep -c "$device" "$logfile")

    # Get first timestamp
    first_ts=$(grep "$device" "$logfile" | awk 'NR==1{print $1}')

    # Get last timestamp
    last_ts=$(grep "$device" "$logfile" | awk 'END{print $1}')

    echo "Device: $device"
    echo "  Total entries: $count"
    echo "  First entry: $first_ts"
    echo "  Last entry: $last_ts"
done

