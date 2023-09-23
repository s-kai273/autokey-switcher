#!/bin/sh
SLEEP_INTERVAL=1
BASH_COMMAND=`xdotool getwindowfocus getwindowname`
PreFocusApp=""
CONFIG_PATH=$HOME/.config/autokey/data
SCRIPT_FOLDER_NAME=Keybindings
EVACATION_FOLDER_PATH=$HOME/.config/autokey/evac

start () {
  cp -r "$EVACATION_FOLDER_PATH/$SCRIPT_FOLDER_NAME" $CONFIG_PATH
  killall autokey-gtk
  autokey-gtk &
}

stop () {
  rm -rf "$CONFIG_PATH/$SCRIPT_FOLDER_NAME"
  killall autokey-gtk
  autokey-gtk &
}

while [ true ]
do
  FocusApp=`xdotool getwindowfocus getwindowname`
  if [ "$FocusApp" = "$PreFocusApp" ] ; then
    echo "## continue"
    PreFocusApp=$FocusApp
    sleep $SLEEP_INTERVAL
    continue
  fi

  if [ "$PreFocusApp" = "$BASH_COMMAND" ] && [ "$FocusApp" != "$BASH_COMMAND" ] ; then
    echo "## start"
    start
  elif [ "$PreFocusApp" != "$BASH_COMMAND" ] && [ "$FocusApp" = "$BASH_COMMAND" ] ; then
    echo "## stop"
    stop
  fi

  PreFocusApp=$FocusApp
  sleep $SLEEP_INTERVAL
done


