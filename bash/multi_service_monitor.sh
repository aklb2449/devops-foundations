#!/bin/bash

SERVICES=("cron" "dbus")
LOGFILE="/var/log/multi_service_monitor.log"

for SERVICE in "${SERVICES[@]}"; do
  if systemctl is-active --quiet "$SERVICE"; then
    echo "$(date): $SERVICE is running" | tee -a "$LOGFILE"
  else
    echo "$(date): $SERVICE is DOWN. Restarting..." | tee -a "$LOGFILE"
    systemctl restart "$SERVICE"

    if systemctl is-active --quiet "$SERVICE"; then
      echo "$(date): $SERVICE restarted successfully" | tee -a "$LOGFILE"
    else
      echo "$(date): FAILED to restart $SERVICE" | tee -a "$LOGFILE"
    fi
  fi
done
