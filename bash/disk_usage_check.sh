#!/bin/bash

THRESHOLD=80
USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
  echo "$(date): WARNING - Disk usage is ${USAGE}%"
else
  echo "$(date): Disk usage is normal at ${USAGE}%"
fi
