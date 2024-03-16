#!/bin/bash

function region_screenshot {
  grim -g "$(slurp)" - | swappy -f -
}

function file_screenshot {
  swappy -f "~/Desktop/my-gnome-saved-file.png"
}

function stdout_screenshot {
  grim -g "$(slurp)" - | swappy -f - -o - | pngquant -
}

function window_screenshot {
  grim -g "$(hyprctl activewindow | awk '/at:/ {print $2} /size:/ {print $2}' | tr '\n' ',' | sed 's/,$/\n/' | awk -F ',' '{print $1","$2" "$3"x"$4}')" - | swappy -f -
}
function full_screenshot {
  grim
  if [ $? -eq 0 ]; then
    notify-send -u low -t 2000 "Screenshot stored in ~/Pictures"
  fi
}

function custom_slurp {
  slurp -d -c \#ffffff -b \#00000000
  
}

case "$1" in
  region)
    region_screenshot
  ;;
  file)
    file_screenshot
  ;;
  stdout)
    stdout_screenshot
  ;;
  window)
    window_screenshot
  ;;
  full)
    full_screenshot
  ;;
  aspect_visualizer)
    custom_slurp
  ;;
  *)
    echo "Invalid argument. Please use one of the following: region, file, stdout, window, full, custom"
  ;;
esac