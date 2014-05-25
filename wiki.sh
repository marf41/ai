#!/bin/sh
pacman -S --needed w3m
w3m -dump https://wiki.archlinux.org/index.php/Installation_guide | sed '/Contents/,/Retrieved from/!d'
