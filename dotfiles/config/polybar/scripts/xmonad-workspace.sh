#!/bin/sh
/usr/bin/xmonad-log | /usr/bin/gawk -F: '{print " " $1}'
