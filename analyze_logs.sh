#!/bin/bash

echo "Select log file to analyze:"
echo "1) Heart Rate (heart_rate.log)"
echo "2) Temperature (temperature.log)"
echo "3) Water Usage (water_usage.log)"
read -p "Enter choice (1-3): " choice

if [ "$choice" = "1" ] || [ "$choice" = "2" ] || [ "$choice" = "3" ]; then
    echo "You selected option $choice"

  else

    echo "Invalid choice, please enter 1, 2, or 3."
    exit 1
    #something
fi

Done
