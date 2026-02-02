#!/bin/bash

mkdir -p hospital_data/{active_logs,archived_logs}

ACTIVE_DIR="hospital_data/active_logs"
ARCHIVE_BASE="hospital_data/archived_logs"

while true; do
    echo "Select log file to archive:"
    echo "1) Heart Rate (heart_rate.log)"
    echo "2) Temperature (temperature.log)"
    echo "3) Water Usage (water_usage.log)"
    read -p "Enter choice (1-3): " choice

    case "$choice" in
        1)
            ARCHIVE_DIR="$ARCHIVE_BASE/heart_data_archive"
	    logfile="heart_rate.log"
	    break
            ;;
        2)
            ARCHIVE_DIR="$ARCHIVE_BASE/temperature_data_archive"
	    logfile="temperature.log"
	    break
            ;;
        3)
            ARCHIVE_DIR="$ARCHIVE_BASE/water_usage_data_archive"
	    logfile="water_usage.log"
	    break
            ;;
	*)
	    echo "Invalid choice, please enter 1, 2, or 3."
	    ;;
    esac
done

SOURCE="$ACTIVE_DIR/$logfile"
if [[ ! -f "$SOURCE" ]]; then
    echo "Error: '$logfile' does not exist."
    exit 1
fi

mkdir -p "$ARCHIVE_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H:%M:%S")
BASE_NAME="${logfile%.*}"
DEST="$ARCHIVE_DIR/${BASE_NAME}_${TIMESTAMP}.log"

echo "Archiving $logfile..."
mv "$SOURCE" "$DEST"
touch "$SOURCE"

echo "Successfully archived to $DEST"
