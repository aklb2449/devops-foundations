#!/bin/bash

SERVICE="$1"
LOGFILE="/var/log/service_monitor.log"

if [ -z "$SERVICE" ]; then
  echo "Usage: $0 <service-name>"
  exit 1
fi

if systemctl is-active --quiet "$SERVICE"; then
  echo "$(date): $SERVICE is running" | tee -a "$LOGFILE"
else
  echo "$(date): $SERVICE is DOWN. Restarting..." | tee -a "$LOGFILE"
  systemctl restart "$SERVICE"

  if systemctl is-active --quiet "$SERVICE"; then
    echo "$(date): $SERVICE restarted successfully" | tee -a "$LOGFILE"
  else
    echo "$(date): FAILED to restart $SERVICE" | tee -a "$LOGFILE"
    exit 2
  fi
fi
