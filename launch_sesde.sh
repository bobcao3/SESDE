#!/bin/sh
export Launcher="/usr/share/ALaunch/main.rb"

/usr/share/APanel/main.rb &
/usr/bin/plank &

echo "Launched"

./session.rb
