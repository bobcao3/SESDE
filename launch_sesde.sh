#!/bin/sh
export Launcher="/usr/bin/ALaunch.rb"

/usr/bin/APanel.rb &
/usr/bin/plank &

echo "Launched"

./session.rb
