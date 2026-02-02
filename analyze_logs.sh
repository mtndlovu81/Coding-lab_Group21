#!/bin/bash

mkdir -p hospital_data/{active_logs,reports}

log_dir="hospital_data/active_logs"
report="hospital_data/reports/analysis_report.txt"

# --- Input loop with case ---
while true; do
    echo "Select log file to analyze:"
    echo "1) Heart Rate (heart_rate.log)"
    echo "2) Temperature (temperature.log)"
    echo "3) Water Usage (water_usage.log)"
    read -p "Enter choice (1-3): " choice

    case "$choice" in
        1)
            logfile="$log_dir/heart_rate.log"
            break
            ;;
        2)
            logfile="$log_dir/temperature.log"
            break
            ;;
        3)
            logfile="$log_dir/water_usage.log"
            break
            ;;
        *)
            echo "Invalid choice, please enter 1, 2, or 3."
            ;;
    esac
done

# --- Check if file exists ---
if [ ! -f "$logfile" ]; then
    echo "Log file '$logfile' not found!"
    exit 1
fi

echo "Analyzing $logfile ..."

# --- Analysis ---
# Assuming log format: "timestamp device_name value"
devices=$(awk '{print $3}' "$logfile" | sort | uniq)

for device in $devices; do
    count=$(grep -c "$device" "$logfile")
    first_ts=$(grep "$device" "$logfile" | awk 'NR==1{print $1, $2}')
    last_ts=$(grep "$device" "$logfile" | awk 'END{print $1, $2}')

    echo -e "Device: $device\n\tTotal entries: $count\n\tFirst entry: $first_ts\n\tLast entry:  $last_ts" >> "$report"
done

echo "Analysis completed."

