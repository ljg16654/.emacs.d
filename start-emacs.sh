#!/bin/sh

syndaemon -K -i 0.5 -R -d
xmodmap ~/.Xmodmap &
redshift -l 31:121 &
~/scripts/tmux_initialize_sessions.sh &
compton --conf ~/.config/compton/compton.conf &
xinput set-prop 'DELL097D:00 04F3:311C Touchpad' 'Device Enabled' 0 &
feh --bg-fill /home/jigang/Pictures/Wallpaper_xps15/vhlcz18j9by41.jpeg
exec dbus-launch --exit-with-session emacs -mm --debug-init
