#! /bin/sh
### BEGIN INIT INFO
# Provides:          hive-preparefs
# Required-Start:    
# Required-Stop:
# Default-Start:     S
# Default-Stop:
# X-Start-Before:    mountkernfs $local_fs udev console-setup $remote_fs
# Short-Description: mount virtual HIVE rootFS rw
# Description:       mount virtual HIVE rootFS rw
### END INIT INFO

. /lib/lsb/init-functions
. /lib/init/vars.sh
PATH=/sbin:/bin

case "$1" in
  start|"")
  
	#Create tmpfs for HIVE and remount dirs  that should be RW
	mount -t tmpfs none /mnt
	mkdir -p /mnt/hiveramfs
	mkdir -p /mnt/hiveramfs/var/lib
		
	cp -R /etc /mnt/hiveramfs
	mount --bind /mnt/hiveramfs/etc /etc
	
	cp -R /var/lock /mnt/hiveramfs/var
	mount --bind /mnt/hiveramfs/var/lock /var/lock
	
	cp -R /var/lib/dbus /mnt/hiveramfs/var/lib
	mount --bind /mnt/hiveramfs/var/lib/dbus /var/lib/dbus
		
	cp -R /var/lib/dhcp /mnt/hiveramfs/var/lib
	mount --bind /mnt/hiveramfs/var/lib/dhcp /var/lib/dhcp
	
	cp -R /var/lib/apt /mnt/hiveramfs/var/lib
	mount --bind /mnt/hiveramfs/var/lib/apt /var/lib/apt
	
	cp -R /var/lib/nfs /mnt/hiveramfs/var/lib
	mount --bind /mnt/hiveramfs/var/lib/nfs /var/lib/nfs
	
	cp -R /var/spool /mnt/hiveramfs/var
	mount --bind /mnt/hiveramfs/var/spool /var/spool
	
	exit $?
	;;
  restart|reload|force-reload)
	echo "Error: argument '$1' not supported" >&2
	exit 3
	;;
  stop|status)
	# No-op
	;;
  *)
	echo "Usage: hive-preparefs.sh [start|stop]" >&2
	exit 3
	;;
esac

:
