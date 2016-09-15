#!/bin/bash
### BEGIN INIT INFO
# Provides:          install.sh
# Required-Start:    apache2 start
# Required-Stop:     apache2 start
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Simple configuration procedure
# Description:       A simple script to start the needed configuration procedure
### END INIT INFO
clear;

# Declaring the environment variables
CONFIG_FILE=$(pwd)"/apache.conf";
CONFIG_AV_FILE="/etc/apache2/conf-available/http-response.conf";
CONFIG_EN_FILE="/etc/apache2/conf-enabled/http-response.conf";
LINK_CREATE=$CONFIG_FILE" "$CONFIG_AV_FILE;
LINK_ACTIVATE=$CONFIG_AV_FILE" "$CONFIG_EN_FILE

start(){

	if [ -e "$CONFIG_EN_FILE" ] ; then
	echo 'The link already exists. This program is terminated.';
	exit 0;
	else
		echo 'Will create the first symbolic link';
		ln -s $LINK_CREATE;
		if [ $? -eq 0 ] ; then
		echo Symbolic link $CONFIG_AV_FILE successfully created!;
		else
		echo 'Something went wrong. This program is terminated.';
		exit 0;
		fi
	sleep 1;
		#
		echo 'Will create the second symbolic link';
		ln -s $LINK_ACTIVATE;
		if [ $? -eq 0 ] ; then
		echo Symbolic link $CONFIG_EN_FILE successfully created!;
		else
		echo 'Something went wrong. This program is terminated.';
		exit 0;
		fi
	sleep 1;
		#
		echo 'Will restart the Apache server';
		service apache2 restart
		if [ $? -eq 0 ] ; then
		echo The server was successfully restarted!;
		echo This program is terminated.;
		else
		echo 'Something went wrong. This program is terminated.';
		exit 0;
		fi
	sleep 1;
	fi
}

stop(){

	echo 'Will remove the first symbolic link';
	rm $CONFIG_AV_FILE;
	if [ $? -eq 0 ] ; then
	echo Symbolic link $CONFIG_AV_FILE successfully removed!;
	else
	echo 'Something went wrong. This program is terminated.';
	exit 0;
	fi
sleep 1;
	#
	echo 'Will remove the second symbolic link';
	rm $CONFIG_EN_FILE;
	if [ $? -eq 0 ] ; then
	echo Symbolic link $CONFIG_EN_FILE successfully removed!;
	else
	echo 'Something went wrong. This program is terminated.';
	exit 0;
	fi
sleep 1;
	#
	echo 'Will restart the Apache server';
	service apache2 restart
	if [ $? -eq 0 ] ; then
	echo The server was successful restarted!;
	echo This program is terminated.;
	else
	echo 'Something went wrong. This program is terminated.';
	exit 0;
	fi
sleep 1;

}

case "$1" in
"start") start ;;
"stop") stop ;;
*) echo "Use 'start', 'stop' commands!";
esac

