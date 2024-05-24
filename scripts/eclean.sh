notify-send "Cleaning up the system..."

sudo sh -c '
pacman -Qdtq | pacman -Rns -
pacman -Qqd | pacman -Rsu -
pacman -Scc --noconfirm && yay -Scc --noconfirm
paccache -rk0
fstrim -av
'
if [ $? -eq 0 ]; then
  notify-send "System cleanup complete!"
else
  notify-send "System cleanup failed!"
fi
