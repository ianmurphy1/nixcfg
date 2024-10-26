#!/usr/bin/env bash

# Lock screen if not already locked and stop playing media

#playerctl pause
pidof hyprlock || hyprlock
