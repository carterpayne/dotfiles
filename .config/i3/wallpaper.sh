#!/usr/bin/env bash
CURRENT_WALLPAPER=0

switch_wallpaper() {
  feh --bg-scale /usr/share/backgrounds/$CURRENT_WALLPAPER.jpg
}

start_timer() {
  while true; do
    sleep 20m
    CURRENT_WALLPAPER=$((CURRENT_WALLPAPER+1))
    if [ ! -f "/usr/share/backgrounds/$CURRENT_WALLPAPER.jpg" ]; then
      CURRENT_WALLPAPER=0
    fi
    switch_wallpaper
  done
}

switch_wallpaper
start_timer
