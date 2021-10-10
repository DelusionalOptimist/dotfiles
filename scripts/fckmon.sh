#!/bin/zsh

xrandr --newmode "1368x768_60.00"   85.25  1368 1440 1576 1784  768 771 781 798 -hsync +vsync & sleep 2
xrandr --addmode DP1 1368x768_60.00 & sleep 2
xrandr --output DP1 --mode 1368x768_60.00 & sleep 2
xrandr --output DP1 --right-of eDP1
