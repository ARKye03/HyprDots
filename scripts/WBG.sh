#!/bin/bash

# Directory containing the wallpapers
wallpaper_dir="/home/archkye/backgrounds/wallpapers"

# File to store the current wallpaper index
index_file="./current_index.txt"

# Array of all wallpapers
wallpapers=($wallpaper_dir/*)

# Number of wallpapers
num_wallpapers=${#wallpapers[@]}

# Function to select a specific wallpaper
select_wallpaper() {
  killall wbg
  wbg "${wallpapers[$1]}"
  echo $1 > $index_file
}

# Function to select a random wallpaper
random_wallpaper() {
  killall wbg
  rand_index=$((RANDOM % num_wallpapers))
  wbg "${wallpapers[$rand_index]}"
  echo $rand_index > $index_file
}

# Function to select the next wallpaper
next_wallpaper() {
  killall wbg
  # Get the current wallpaper index
  if [ -f $index_file ]; then
    current_index=$(cat $index_file)
  else
    current_index=0
  fi
  
  # Calculate the next index
  next_index=$(( (current_index + 1) % num_wallpapers ))
  
  # Write the new index to the file
  echo $next_index > $index_file
  
  # Set the next wallpaper
  wbg "${wallpapers[$next_index]}"
}

prev_wallpaper() {
  killall wbg
  # Get the current wallpaper index
  if [ -f $index_file ]; then
    current_index=$(cat $index_file)
  else
    current_index=0
  fi
  
  # Calculate the next index
 prev_index=$(( (current_index - 1) % num_wallpapers ))
  
  # Write the new index to the file
  echo $prev_index > $index_file
  
  # Set the next wallpaper
  wbg "${wallpapers[$prev_index]}"
}

# Check the command line arguments
if [ "$1" == "select" ]; then
  select_wallpaper $2
  elif [ "$1" == "random" ]; then
  random_wallpaper
  elif [ "$1" == "next" ]; then
  next_wallpaper
  elif [ "$1" == "prev" ]; then
  prev_wallpaper
else
  echo "Invalid command. Use 'select', 'random', or 'next'."
fi
