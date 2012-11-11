#!/bin/sh

env DISPLAY=:0.0 compton -cC -fF -G -m 0.9 &
env DISPLAY=:0.1 compton -cC -fF -G -m 0.9 &
env DISPLAY=:0.2 compton -cC -fF -G -m 0.9 &

pgrep -u $USER -x "urxvtd" || (urxvtd -q -o -f)
pgrep -u $USER -x "dropbox" || (dropbox start &)
pgrep -u $USER -f "SickBeard" || (/home/france_a/Work/Web/sickbeard/SickBeard.py --daemon --quiet)
pgrep -u $USER -f "chromium-browser" || (env DISPLAY=:0.0 chromium-browser &)
pgrep -u $USER -f "urxvt_rsync-log" || urxvt -pe default -geometry 170x30 -display :0.2 -title urxvt_rsync-log -e tail -f /var/log/rsync.start.log &
pgrep -u $USER -f "urxvt_weechat-curses" || urxvt -pe default -display :0.1 -title urxvt_weechat-curses -e weechat-curses &
pgrep -u $USER -f "urxvt_session" || urxvt -pe default -display :0.0 -title urxvt_session &
pgrep -u $USER -f "thunderbird" || (env DISPLAY=:0.1 thunderbird &)
pgrep -u $USER -f "urxvt_midnight-commander" || urxvt -pe default -display :0.0 -title urxvt_midnight-commander -e env EDITOR=emacs mc &
pgrep -u $USER -x "conky" || (sleep 3s && env DISPLAY=:0.2 conky -c /home/france_a/.conky/conkyrc_grey &)
pgrep -u $USER -x "xscreensaver" || (xscreensaver &)
pgrep -u $USER -x "vmware" || (env DISPLAY=:0.2 vmware &)
pgrep -u $USER -x "skype" || (env DISPLAY=:0.1 skype &)
