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

ACTION=$1;

SYS_NAME="http-response";
SYS_STATUS=`curl -sL -w "%{http_code} %{url_effective}\\n" "http://127.0.0.1/$SYS_NAME" -o /dev/null | awk '{print $1}'`;
SYS_DIR="/opt/"$SYS_NAME"/";
SYS_CONFIG_DIR=$SYS_DIR;
SYS_APACHE_CONFIG_FILE=$SYS_CONFIG_DIR"apache.conf"
SYS_SCRIPT_INSTALL=$SYS_CONFIG_DIR"install.sh"
SYS_SCRIPT_INDEX=$SYS_DIR"index.php"

APACHE_USER="www-data";
APACHE_DIR="/etc/apache2/";
APACHE_HTDOCS="/var/www/html/";
APACHE_CONF_AVAILABLE_FILE=$APACHE_DIR"conf-available/"$SYS_NAME".conf ";
APACHE_CONF_ENABLED_FILE=$APACHE_DIR"conf-enabled/"$SYS_NAME".conf ";

SET_PERMISSIONS=(
    $SYS_SCRIPT_INSTALL
);
PERMISSIONS=${#SET_PERMISSIONS[@]};

SET_SYMBOLIC_LINKS=(
    "$SYS_APACHE_CONFIG_FILE $APACHE_CONF_AVAILABLE_FILE"
    "$APACHE_CONF_AVAILABLE_FILE $APACHE_CONF_ENABLED_FILE"
);
SYMBOLIC_LINKS=${#SET_SYMBOLIC_LINKS[@]};

UNSET_SYMBOLIC_LINKS=(
    "$APACHE_CONF_AVAILABLE_FILE"
    "$APACHE_CONF_ENABLED_FILE"
);
SYMBOLIC_LINKS_UNSET=${#UNSET_SYMBOLIC_LINKS[@]};

start(){
    # Sets the directories permissions
    set_permissions;
    # Creates all symbolic links
    create_links;
    # Restarts the Apache Server
    service apache2 restart;
    if [ $? -eq 0 ] ; then
        echo "The server was successfully restarted!";
    else
        echo "Something went wrong while restarting server";
        exit 1;
    fi
    echo "All done!";
}

stop(){
    if [ $SYS_STATUS != 200 ] ; then
        echo "The system is already offline. You should use the 'start' parameter.";
        echo "We'll do this for you right now. Wait, please...";
        sleep 5;
        start;
        exit 0;
    fi
    # Unsets the permissions of the directories
    unset_permissions;
    # Removes all symbolic links
    remove_links;
    # Restarts the Apache Server
    service apache2 restart;
    if [ $? -eq 0 ] ; then
        echo "The server was successfully restarted!";
    else
        echo "Something went wrong while restarting server";
        exit 1;
    fi
    echo "All done!";
}

create_links(){
    echo "Creating all symbolic links...";
    for (( i=0; i<$SYMBOLIC_LINKS; i++)); do
        VAR=${SET_SYMBOLIC_LINKS[${i}]};
        ln -s $VAR;
    done;
    sleep 2;
}

remove_links(){
    echo "Removing all symbolic links...";
    for (( i=0; i<$SYMBOLIC_LINKS_UNSET; i++)); do
        VAR=${UNSET_SYMBOLIC_LINKS[${i}]};
        rm -r $VAR;
    done;
    sleep 2;
}

set_permissions(){
    echo "Setting permissions...";
    for (( i=0; i<$PERMISSIONS; i++)); do
        VAR=${SET_PERMISSIONS[${i}]};
        chmod +x $VAR;
        echo "Setting execution permission in '$VAR'...";
    done;
    sleep 2;
}

unset_permissions(){
    echo "Unsetting permissions...";
    for (( i=0; i<$PERMISSIONS; i++)); do
        VAR=${SET_PERMISSIONS[${i}]};
        chmod 644 $VAR;
        echo "Unsetting execution permission in '$VAR'...";
    done;
    sleep 2;
}

case "$1" in
"start") start ;;
"stop") stop ;;
"restart") stop ; start ;;
*) echo "Use 'start', 'stop' or 'restart' commands!";
esac
