-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" }, "" .. colyel .. " at" .. coldef .. colbyel .. " %H:%M:%S " .. coldef .. "", 1)

-- Create a systray
mysystray = widget({ type = "systray" })

-- CPU widget
cputwidget = widget({ type = "textbox" })
vicious.register(cputwidget, vicious.widgets.cpu,
		 function (widget, args)
		    return "| ".. colblu .. "cpu " .. coldef .. colbblu .. string.format("% 3d%%", args[2]) .. coldef .. " - " .. colbgre .. string.format("% 3d%%", args[3]) .. coldef .. " - " .. colbyel .. string.format("% 3d%%", args[4]) .. coldef .. " - " .. colbred .. string.format("% 3d%%", args[5]) .. coldef .. " "
		 end )
cputwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e htop --sort-key PERCENT_CPU") end ) ) )

-- Ram widget
memwidget = widget({ type = "textbox" })
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem, "" .. colyel .. "ram " .. coldef .. colbyel .. "$1%" .. coldef .. ", (" .. colbgre .. "$2 MiB" .. coldef .. ") ", 5)

-- temp monitor
tempmonitor	=	widget({ type = "textbox", name = "tempmonitor", align = "center" })

function temp()
   local fddisk = io.popen("/home/" .. USER .. "/.config/awesome/bin/coretemp")
   local status = fddisk:read()
   fddisk:close()
   return status:split(" ")
end

vicious.register(tempmonitor, temp, "| ".. colblu .. "temp  " .. coldef .. colbblu .. "$1" .. coldef .. " - " .. colbgre .. "$2" .. coldef .. " - " .. colbyel .. "$3" .. coldef .. " - " .. colbred .. "$4" .. coldef .. "", 5)

-- Calendar widget
calwidget = widget({ type = "textbox" })
function dayth()
   local osd = os.date("%d")
   if osd == "01" or osd == "21" or osd == "31" then
      return "<span font='proggytiny 7'><sup>st</sup></span>"
   elseif osd == "02" or osd == "22" then
      return "<span font='proggytiny 7'><sup>nd</sup></span>"
   elseif osd == "03" or osd == "23" then
      return "<span font='proggytiny 7'><sup>rd</sup></span>"
   else
      return "<span font='proggytiny 7'><sup>th</sup></span>"
   end
end
vicious.register(calwidget, vicious.widgets.date, " |" .. colbyel .. " %a, %d" .. dayth() .. " %B" .. coldef .. "")

-- Volume widget
volwidget = widget({ type = "textbox" })
vicious.register(volwidget, vicious.widgets.volume,
		 function (widget, args)
		    if args[1] == 0 or args[2] == "♩" then
		       return "" .. colgre .. "volume " .. coldef .. colbred .. "mute" .. coldef .. ""
		    else
		       return "" .. colgre .. "volume " .. coldef .. colbgre .. args[1] .. "%" .. coldef .. ""
		    end
		 end, 0, "Master" )
volwidget:buttons(
   awful.util.table.join(
      awful.button({ }, 1, function ()
			      awful.util.spawn("amixer -q sset Master toggle") 
			      vicious.force({volwidget})
			   end),
      awful.button({ }, 3, function ()
			      awful.util.spawn( terminal .. " -e alsamixer") 
			      vicious.force({volwidget})
			   end),
      awful.button({ }, 4, function ()
			      awful.util.spawn("amixer -q sset Master 2dB+")
			      vicious.force({volwidget})
			   end),
      awful.button({ }, 5, function ()
			      awful.util.spawn("amixer -q sset Master 2dB-")
			      vicious.force({volwidget})
			   end)
   )
)

-- rotate screen
rotate		=	widget({ type = "textbox", name = "rotate", align = "left"})

function readRotate()
   local fddisk = io.popen("/home/" .. USER .. "/.config/awesome/bin/rotateInfos")
   local status = fddisk:read()
   fddisk:close()
   return {status}
end

vicious.register(rotate, readRotate,
		 function (widget, args)
		    if args[1] == "normal" then
		       return "| " .. colblu .. "rotate " .. coldef .. colbblu .. args[1] .. coldef .. " | "
		    else
		       return "| " .. colblu .. "rotate " .. coldef .. colbred .. args[1] .. coldef .. " | "
		    end
		 end, 0)

rotate:buttons(
   awful.util.table.join(awful.button({}, 1, function ()
						awful.util.spawn("/home/" .. USER .. "/.config/awesome/bin/rotate.sh", false)
					     end))
)

-- layout change
layoutmonitor	=	widget({ type = "textbox", name = "layoutmonitor", align = "center" })

function layout()
   local fddisk = io.popen("/home/" .. USER .. "/.config/awesome/bin/getLayout.sh")
   local status = fddisk:read()
   fddisk:close()
   return {status}
end

vicious.register(layoutmonitor, layout, "" .. colblu .. " layout " .. coldef .. colbblu .."$1" .. coldef .. " | ", 0)
layoutmonitor:buttons(
   awful.util.table.join(awful.button({}, 1, function ()
						os.execute("/home/" .. USER .. "/.config/awesome/bin/chLayout.sh")
						vicious.force({layoutmonitor})
					     end))
)

-- Weather widget
weatherwidget = widget({ type = "textbox" })
vicious.register(weatherwidget, vicious.widgets.weather,
		 function (widget, args)
		    return " |" .. colblu .. " weather " .. coldef .. colbblu .. string.lower(args["{sky}"]) .. ",  " .. string.lower(args["{tempc}"]) .. "°C" .. coldef .. " | "
		 end, 360, "LFPO" )
weatherwidget:buttons(
   awful.util.table.join(awful.button({}, 1, function ()
						vicious.force({weatherwidget})
					     end))
)
