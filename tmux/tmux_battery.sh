#!/bin/sh

pmset -g batt |xargs | sed 's/.*) \([^ ]*\)%.*/\1%/'
