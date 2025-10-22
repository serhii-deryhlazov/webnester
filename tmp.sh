#!/bin/bash

# Check if argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <number>"
    echo "Please provide a number as an argument"
    exit 1
fi

# Get the number from command line argument
number=$1

# Check if input is a valid number
if ! [[ "$number" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
    echo "Error: '$number' is not a valid number"
    exit 1
fi

# Calculate
result=0
for ((i=0; i<number; i++)); do
    result=$(echo "$result * 1.3 + 500" | bc -l)
    echo $result
done
