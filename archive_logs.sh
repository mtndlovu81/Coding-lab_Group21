#!/bin/bash

ACTIVE_DIR="hospital_data/active_logs"
ARCHIVE_BASE="hospital_data/archives"

echo "Select log to archive:"
select log_file in "heart_rate_log.log" "temperature_log.log" "water_usage_log.log"; do
    if [[ -z "$log_file" ]]; then
        echo "Invalid selection. Please choose 1, 2, or 3."
        continue
    fi

    case "$log_file" in
        heart_rate_log.log)
            ARCHIVE_DIR="$ARCHIVE_BASE/heart"
            ;;
        temperature_log.log)
            ARCHIVE_DIR="$ARCHIVE_BASE/temperature"
            ;;
        water_usage_log.log)
            ARCHIVE_DIR="$ARCHIVE_BASE/water"
            ;;
    esac

    SOURCE="$ACTIVE_DIR/$log_file"

    if [[ ! -f "$SOURCE" ]]; then
        echo "Error: $log_file does not exist."
        exit 1
    fi

    mkdir -p "$ARCHIVE_DIR"

    TIMESTAMP=$(date +"%Y-%m-%d_%H:%M:%S")
    BASE_NAME="${log_file%.*}"
    DEST="$ARCHIVE_DIR/${BASE_NAME}_${TIMESTAMP}.log"

    echo "Archiving $log_file..."
    mv "$SOURCE" "$DEST"
    touch "$SOURCE"

    echo "Successfully archived to $DEST"
    break
done

