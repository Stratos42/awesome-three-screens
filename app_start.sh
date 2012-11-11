#!/bin/sh

env DISPLAY=:0.0 compton -cC -fF -G -m 0.9 &
env DISPLAY=:0.1 compton -cC -fF -G -m 0.9 &
env DISPLAY=:0.2 compton -cC -fF -G -m 0.9 &

pgrep -u $USER -x "urxvtd" || (urxvtd -q -o -f)
pgrep -u $USER -x "dropbox" || (dropbox start &)
pgrep -u $USER -f "chromium-browser" || (env DISPLAY=:0.0 chromium-browser &)
pgrep -u $USER -f "urxvt_weechat-curses" || urxvt -pe default -display :0.1 -title urxvt_weechat-curses -e weechat-curses &
pgrep -u $USER -f "urxvt_session" || urxvt -pe default -display :0.0 -title urxvt_session &
pgrep -u $USER -f "urxvt_midnight-commander" || urxvt -pe default -display :0.0 -title urxvt_midnight-commander -e env EDITOR=emacs mc &
pgrep -u $USER -x "skype" || (env DISPLAY=:0.1 skype &)
