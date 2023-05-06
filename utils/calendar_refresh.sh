#!/usr/bin/env bash

echo "Stopping agent"
launchctl stop com.apple.CalendarAgent
echo "Sleeping for 5 seconds"
sleep 5
launchctl start com.apple.CalendarAgent
echo "Starting agent again"
