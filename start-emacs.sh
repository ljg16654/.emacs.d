#!/bin/sh

syndaemon -K -i 0.5 -R -d
xmodmap ~/.Xmodmap &
redshift -l 31:121 &
# compton --conf ~/.config/compton/compton.conf &
xinput set-prop 'DELL097D:00 04F3:311C Touchpad' 'Device Enabled' 0 &
exec dbus-launch --exit-with-session emacs -mm --debug-init
