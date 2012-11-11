-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

-- Couleurs
require("colours")

-- Widgets Library
vicious = require("vicious")
require("widgets")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Utils

function string:split(sep)
   local sep, fields = sep or " ", {}
   local pattern = string.format("([^%s]+)", sep)
   self:gsub(pattern, function(c) fields[#fields+1] = c
		      end)
   return fields
end

-- }}}

-- {{{ Variable definitions
USER		=	os.getenv("USER")

-- -- notifications
naughty.config.default_preset.timeout          = 5
naughty.config.default_preset.screen           = 1
naughty.config.default_preset.position         = "top_right"
naughty.config.default_preset.margin           = 4
naughty.config.default_preset.height           = 20
naughty.config.default_preset.width            = 550
naughty.config.default_preset.gap              = 1
naughty.config.default_preset.ontop            = true
naughty.config.default_preset.icon             = nil
naughty.config.default_preset.fg               = trwhi --beautiful.fg_focus or '#ffffff'
naughty.config.default_preset.bg               = red --beautiful.bg_focus or '#535d6c'

naughty.config.presets.low.timeout = 10
naughty.config.presets.normal.timeout = 5
naughty.config.presets.critical.timeout = 0

-- Themes define colours, icons, and wallpapers
beautiful.init("/home/" .. USER .. "/.config/awesome/themes/dark/theme.lua")

-- This is used later as the default terminal and editor to run.
urxvt_cmd	=	"urxvt -pe default "
terminal	=	"xterm"
chromium	=	"chromium --allow-running-insecure-content"
firefox		=	"firefox"
editor		=	"emacs"
editor_cmd	=	"urxvt -pe default -e " .. editor
irc_cmd		=	"urxvt -pe default -e weechat-curses"
mc_cmd		=	"urxvt -pe default -e env EDITOR=emacs mc"
gimp		=	"gimp"
halt		=	"sudo /sbin/halt"
reboot		=	"sudo /sbin/reboot"
pidgin		=	"pidgin"

-- Default modkey.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
   {
   awful.layout.suit.floating,
   awful.layout.suit.tile,
   -- awful.layout.suit.tile.left,
   awful.layout.suit.tile.bottom
   -- awful.layout.suit.tile.top,
   -- awful.layout.suit.fair,
   -- awful.layout.suit.fair.horizontal,
   -- awful.layout.suit.spiral,
   -- awful.layout.suit.spiral.dwindle,
   -- awful.layout.suit.max,
   -- awful.layout.suit.max.fullscreen,
   -- awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags =
   {
   names = { "[1:sys]", "[2:misc]", "[3:dev1]", "[4:dev2]", "[5:web]", "[6:dev3]", "[7:misc]", "[8:float]" },
   layout = { layouts[2], layouts[2], layouts[2], layouts[2], layouts[1], layouts[2], layouts[2], layouts[1] }
}
tag3 =
   {
   names = { "[1:misc]", "[2:vm]", "[3:server]" },
   layout = { awful.layout.suit.floating, layouts[2], layouts[2] }
}
tag2 =
   {
   names = { "[1:irc]", "[2:msg]", "[3:mail]" },
   layout = { layouts[2], layouts[1], layouts[2] }
}
tags[1] = awful.tag(tags.names, 1, tags.layout)
tags[3] = awful.tag(tag2.names, 2, tag2.layout)
tags[2] = awful.tag(tag3.names, 3, tag3.layout)
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu =
   {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart }
}

mymainmenu = awful.menu(
   {
      items =
	 {
	 { "awesome", myawesomemenu, beautiful.gentoo_icon },
	 { "terminal", terminal },
	 { "" },
	 { "logout", awesome.quit },
	 { "shutdown", halt },
	 { "reboot", reboot }
      }
   })

mylauncher = awful.widget.launcher(
   {
      image = image(beautiful.gentoo_icon),
      menu = mymainmenu
   })

-- {{{ Wibox
-- Create a wibox for each screen and add it
mywibox1 = {}
mywibox2 = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
   awful.button({	 }, 1, awful.tag.viewonly),
   awful.button({ modkey }, 1, awful.client.movetotag),
   awful.button({	 }, 3, awful.tag.viewtoggle),
   awful.button({ modkey }, 3, awful.client.toggletag),
   awful.button({	 }, 4, awful.tag.viewnext),
   awful.button({	 }, 5, awful.tag.viewprev)
)
mytasklist = { show_icons = false }
mytasklist.buttons = awful.util.table.join(
   awful.button({ }, 1, function (c)
			   if not c:isvisible() then
			      awful.tag.viewonly(c:tags()[1])
			   end
			   client.focus = c
			   c:raise()
			end),
   awful.button({ }, 3, function ()
			   if instance then
			      instance:hide()
			      instance = nil
			   else
			      instance = awful.menu.clients({ width=250 })
			   end
			end),
   awful.button({ }, 2, function (c)
			   c:kill()
			end),
   awful.button({ }, 5, function ()
			   awful.client.focus.byidx(-1)
			   if client.focus then
			      client.focus:raise()
			   end
			end),
   awful.button({ }, 4, function ()
			   awful.client.focus.byidx(1)
			   if client.focus then
			      client.focus:raise()
			   end
			end))

    -- Create a promptbox for screen 1
    mypromptbox[1] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[1] = awful.widget.layoutbox(s)
    mylayoutbox[1]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[1] = awful.widget.taglist(1, awful.widget.taglist.label.all, mytaglist.buttons)
    -- Create a tasklist widget
    mytasklist[1] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, 1)
                                          end, mytasklist.buttons)


    -- Create a promptbox for screen 2
    mypromptbox[2] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[2] = awful.widget.layoutbox(s)
    mylayoutbox[2]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[2] = awful.widget.taglist(2, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[2] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, 2)
                                          end, mytasklist.buttons)
--    awful.widget.layout.margins[mytasklist[2]] = { left = 10 }

    -- Create a promptbox for screen 3
    mypromptbox[3] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[3] = awful.widget.layoutbox(s)
    mylayoutbox[3]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[3] = awful.widget.taglist(3, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[3] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, 3)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox1[1] = awful.wibox({ position = "top", screen = 1 })
    mywibox1[2] = awful.wibox({ position = "top", screen = 2 })
    mywibox1[3] = awful.wibox({ position = "top", screen = 3 })
    mywibox2[1] = awful.wibox({ position = "bottom", screen = 1 })
    -- Add widget1 to the wibox - order matters
    mywibox1[1].widgets = {
       {
	  mypromptbox[1],
	  layout = awful.widget.layout.horizontal.leftright
       },
       mytextclock,
       calwidget,
       volwidget,
       layoutmonitor,
       weatherwidget,
       mysystray or nil,
       layout = awful.widget.layout.horizontal.rightleft,
       mytasklist[1],
       layout = awful.widget.layout.horizontal.rightleft
    }

    mywibox1[2].widgets = {
       {
	  mytaglist[2],
     	  mypromptbox[2],
    	  layout = awful.widget.layout.horizontal.leftright
       },
       mytextclock,
       calwidget,
       mysystray or nil,
       mytasklist[2],
       layout = awful.widget.layout.horizontal.rightleft
    }

    mywibox1[3].widgets = {
       {
	  mytaglist[3],
	  rotate,
     	  mypromptbox[3],
    	  layout = awful.widget.layout.horizontal.leftright
       },
       mytasklist[3],
       mysystray or nil,
       layout = awful.widget.layout.horizontal.rightleft
    }

    mywibox2[1].widgets = {
       tempmonitor,
       cputwidget,
       memwidget,
       layout = awful.widget.layout.horizontal.rightleft,
       {
	  mylauncher,
	  mytaglist[1],
	  layout = awful.widget.layout.horizontal.leftright
       }
    }
 -- end
-- }}}

-- AUTORUN APPS!
awful.util.spawn_with_shell("/home/" .. USER .. "/.config/awesome/app_start.sh")

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,	"Control" }, "Right", function ()
    				    awful.screen.focus_relative(-1)
				    mouse.coords({x = 600, y = 500})
    				 end),
    awful.key({ modkey,	"Control" }, "Left", function ()
    				    awful.screen.focus_relative(1)
				    mouse.coords({x = 600, y = 500})
    				 end),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn("urxvtc") end),
    awful.key({ modkey, "Control" }, "Return", function () awful.util.spawn("urxvt") end),
    awful.key({ modkey,		  }, "F1", function () awful.util.spawn(pidgin) end),
    awful.key({ modkey,		  }, "F2", function () awful.util.spawn(chromium) end),
    awful.key({ modkey,		  }, "F3", function () awful.util.spawn(firefox) end),
    awful.key({ modkey,		  }, "F4", function () awful.util.spawn("gwenview") end),
    awful.key({ modkey,		  }, "F5", function () awful.util.spawn(mc_cmd) end),
    awful.key({ modkey,		  }, "F6", function () awful.util.spawn(irc_cmd) end),
    awful.key({ modkey,           }, "F9", function () awful.util.spawn ( urxvt_cmd .. "-geometry 127x34 -e mutt" ) end),
    awful.key({ modkey,           }, "F10", function () awful.util.spawn( urxvt_cmd .. "-geometry 127x37 -e ncmpcpp")   end),
    awful.key({ modkey,           }, "F12", function () awful.util.spawn("xscreensaver-command -lock") end),
    awful.key({			  }, "#123", function () awful.util.spawn( "amixer -q -c 0 sset Master 0.5%+")   end),
    awful.key({			  }, "#122", function () awful.util.spawn( "amixer -q -c 0 sset Master 0.5%-")   end),
    awful.key({			  }, "#121", function () awful.util.spawn( "amixer -q -c 0 sset Master toggle")   end),
    awful.key({			  }, "#172", function () awful.util.spawn( "mpc toggle")   end),
    awful.key({			  }, "#174", function () awful.util.spawn( "mpc stop")   end),
    awful.key({			  }, "#171", function () awful.util.spawn( "mpc prev")   end),
    awful.key({			  }, "#173", function () awful.util.spawn( "mpc next")   end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey, "Shift"   }, "r",     function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey,           }, "r",     function () awful.util.spawn('/home/' .. USER .. '/.config/awesome/dmenu_wm.sh') end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end),

    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      function(c) awful.client.movetoscreen(c,c.screen-1) end ),
    awful.key({ modkey,           }, "p",      function(c) awful.client.movetoscreen(c,c.screen+1) end ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "Vlc" },
      properties = { floating = true } },
    { rule = { class = "Smplayer" },
      properties = { floating = true } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "Acroread" },
      properties = { floating = true } },
    { rule = { class = "Conky" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { class = "Qiv" },
      properties = { floating = true } },
    { rule = { class = "Pidgin" },
      properties = { tag = tags[3][2] } },
    { rule = { name = "urxvt_session" },
      properties = { tag = tags[1][4], switchtotag = true } },
    { rule = { name = "urxvt_midnight-commander" },
      properties = { tag = tags[1][6] } },
    { rule = { name = "urxvt_weechat-curses" },
      properties = { tag = tags[3][1] } },
    { rule = { name = "urxvt_rsync-log" },
      properties = { tag = tags[2][1] } },
    { rule = { class = "Skype" },
      properties = { tag = tags[3][2] } },
    { rule = { class = "Thunderbird" },
      properties = { floating = true, tag = tags[3][3] } },
    { rule = { class = "Mumble" },
      properties = { tag = tags[3][2] } },
    { rule = { class = "Amarok" },
      properties = { tag = tags[2][1] } },
    { rule = { class = "Uget" },
      properties = { tag = tags[2][1] } },
    { rule = { class = "Vmware" },
      properties = { tag = tags[2][2] } },
    { rule = { name = "Okular" },
      properties = {floating = true} },
    { rule = { class = "Zathura" },
      properties = {floating = true} },
    { rule = { name = "JDownloader" },
      properties = {floating = true} },
    { rule = { name = "Gwenview" },
      properties = {floating = true} },
    { rule = { name = "Notes - Notes" },
      properties = {floating = true} },
    { rule = { class = "Firefox" },
      properties = {floating = true, tag = tags[1][5]} },
    { rule = { class = "Chromium-browser" },
      properties = { tag = tags[1][5]} },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
			       -- Add a titlebar
			       -- awful.titlebar.add(c, { modkey = modkey })

			       -- Enable sloppy focus
			       c:add_signal("mouse::enter", function(c)
							       if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
							       and awful.client.focus.filter(c) then
							       client.focus = c
							    end
							 end)

			       if not startup then
				  -- Set the windows at the slave,
				  -- i.e. put it at the end of others instead of setting it master.
				  -- awful.client.setslave(c)


				  -- Put windows in a smart way, only if they does not set an initial position.
				  if not c.size_hints.user_position and not c.size_hints.program_position then
				     awful.placement.no_overlap(c)
				     awful.placement.no_offscreen(c)
				  end
			       end
			    end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)


vicious.force({layoutmonitor, rotate, volwidget, cputwidget, memwidget, tempmonitor, weatherwidget})
-- }}}
