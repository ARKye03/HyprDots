#sudo paccache -rk0
#sudo pacman -Qdtq | sudo pacman -Rns - ; sudo fstrim -av
#sudo pacman -Scc --noconfirm && yay -Scc --noconfirm
#pacman -Qqd | sudo pacman -Rsu -

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
  notify-send -u critical "System cleanup failed!"
fi
