hyprctl notify 1 5000 "rgb(ff1ea3)" "Cleaning up the system..."

sudo sh -c '
pacman -Qdtq | pacman -Rns -
pacman -Qqd | pacman -Rsu -
pacman -Scc --noconfirm && yay -Scc --noconfirm
paccache -rk0
fstrim -av
'
if [ $? -eq 0 ]; then
  hyprctl notify 1 5000 "rgb(1eff00)" "System cleanup complete!"
else
  hyprctl notify 5 5000 "rgb(ff0000)" "System cleanup failed!"
fi
