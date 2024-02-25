gscreenshot -f ./Screenshots
if [ $? -eq 0 ]; then
    hyprctl notify 1 2000 "rgb(00ce71)" "Screenshot taken"
else
    hyprctl notify 5 10000 "rgb(ce0000)" "Failed to take the screenshot"
fi
