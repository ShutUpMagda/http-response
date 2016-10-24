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

#Cleaning up the screen
clear;

# Declaring the environment variables
APACHE_DIR="/etc/apache2/";
CONFIG_FILE="/usr/share/php/http-response/apache.conf";
CONFIG_AVAILABLE_FILE=$APACHE_DIR"conf-available/http-response.conf";
CONFIG_ENABLED_FILE=$APACHE_DIR"conf-enabled/http-response.conf";
LINK_CREATE=$CONFIG_FILE" "$CONFIG_AVAILABLE_FILE;
LINK_ACTIVATE=$CONFIG_AVAILABLE_FILE" "$CONFIG_ENABLED_FILE
ACTION=$1;

start(){
        echo 'Checking symbolic links...';
	if [ -e "$CONFIG_ENABLED_FILE" ] ; then
            echo 'The link '$CONFIG_ENABLED_FILE' already exists.';
            echo 'This program is terminated.';
            exit 0;
	else
	echo 'Will create the first symbolic link' $CONFIG_AVAILABLE_FILE;
		ln -s $LINK_CREATE;
		if [ $? -eq 0 ] ; then
                    echo Symbolic link $CONFIG_AVAILABLE_FILE successfully created!;
		else
                    echo 'Something went wrong. This program is terminated.';
		exit 0;
		fi
	sleep 1;
		#
	echo 'Will create the second symbolic link' $CONFIG_ENABLED_FILE;
		ln -s $LINK_ACTIVATE;
		if [ $? -eq 0 ] ; then
                    echo Symbolic link $CONFIG_ENABLED_FILE successfully created!;
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
	echo 'Checking symbolic links...';
        if [ -e "$CONFIG_AVAILABLE_FILE" ] ; then
            rm $CONFIG_AVAILABLE_FILE;
            if [ $? -eq 0 ] ; then
                echo Symbolic link $CONFIG_AVAILABLE_FILE successfully removed!;
                #
        echo 'Will remove the second symbolic link';
                rm $CONFIG_ENABLED_FILE;
                if [ $? -eq 0 ] ; then
                    echo Symbolic link $CONFIG_ENABLED_FILE successfully removed!;
                else
                    echo 'Something went wrong. This program is terminated.';
                exit 0;
                fi
        sleep 1;
                #
        echo 'Will restart the Apache server';
                service apache2 restart
                if [ $? -eq 0 ] ; then
                    echo "The server was successful restarted!";
                    echo "This program is terminated.";
                else
                    echo 'Something went wrong. This program is terminated.';
                    exit 0;
                fi
        sleep 1;
                exit 0;
            fi
            else
                echo "File '"$CONFIG_AVAILABLE_FILE"' not found!";
                if [ $ACTION = 'restart' ] ; then
                    start;
                    exit 0;
                fi
                echo 'This program is terminated.';
            exit 0;
        fi
        sleep 1;

}

case "$1" in
"start") start ;;
"stop") stop ;;
"restart") stop; start ;;
*) echo "Use 'start', 'stop' or 'restart' commands!";
esac

