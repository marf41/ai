#!/bin/sh
TMP=$(mktemp)
loadkeys pl
dialog --begin 5 10 --infobox "- create LVM group\n- sth else" 20 40 \
	--and-widget --begin 5 60 --inputbox "LVM group name:" 0 0 "vg" 2>>$TMP
VGNAME=$(tail -n1 $TMP)
VGSIZE=$(vgdisplay $VGNAME | grep VG\ Size | awk '{print $3}')
VGUNIT=$(vgdisplay $VGNAME | grep VG\ Size | awk '{print $4}')
echo $VGNAME
dialog --keep-window --begin 5 10 --infobox "- using LVM group: $VGNAME\n- VG size: $VGSIZE $VGUNIT" 20 40 \
	--and-widget --begin 15 60 --yesno "Create swap partition?" 0 0
if [ "$?" = "0" ]
then
	MEMSIZE=$(head -n1 /proc/meminfo | awk '{print $2}')
	echo vgcreate -C $VGNAME -L ${MEMSIZE}k -n swap
fi
rm $TMP
