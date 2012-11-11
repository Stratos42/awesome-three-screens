------------------------------------
--      "Dark" awesome theme      --
--    By Aurelien F. (Stratros)   --
------------------------------------

-- {{{ Main
theme = {}

theme.font          = "terminus 8"
--theme.wallpaper_cmd = { "awsetbg /home/" .. USER .. "/.config/awesome/themes/wallpaper_dual/fresh-paper.com-wallpaper-19393.jpg" }
theme.wallpaper_cmd = { "/home/" .. USER .. "/.config/awesome/bg-assign.sh" }
-- }}}

theme.bg_normal     = trblk
theme.bg_focus      = trblk
theme.bg_urgent     = red
theme.bg_minimize   = trblk

theme.fg_normal     = brblk
theme.fg_focus      = yel
theme.fg_urgent     = trwhi
theme.fg_minimize   = blk

theme.border_width  = "1"
theme.border_normal = trblk
theme.border_focus  = brblk
theme.border_marked = blu

-- TAGLIST
theme.taglist_squares_sel   = "/home/" .. USER .. "/.config/awesome/themes/dark/taglist/squarefw.png"
theme.taglist_squares_unsel = "/home/" .. USER .. "/.config/awesome/themes/dark/taglist/squarew.png"

-- TASKLIST
theme.tasklist_floating_icon = "/home/" .. USER .. "/.config/awesome/themes/dark/tasklist/floatingw.png"

-- MENU
theme.menu_submenu_icon = "/home/" .. USER .. "/.config/awesome/themes/dark/submenu.png"
theme.menu_border_color = blk
theme.menu_height = "14"
theme.menu_width  = "90"


-- {{{ Titlebars
theme.titlebar_bg_focus  = "#5C5C5C"
theme.titlebar_bg_normal = "#3F3F3F"
-- }}}

-- {{{ Widgets
theme.fg_widget        = "#AECF96"
theme.fg_center_widget = "#88A175"
theme.fg_end_widget    = "#FF5656"
theme.bg_widget        = "#494B4F"
theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
theme.menu_height = "20"
theme.menu_width  = "150"
-- }}}

-- {{{ Theme icon
theme.awesome_icon           = "/usr/share/awesome/themes/zenburn/awesome-icon.png"
theme.gentoo_icon	     = "/home/" .. USER .. "/.config/awesome/themes/dark/gentoo_logo.png"
theme.mail_icon	             = "/home/" .. USER .. "/.config/awesome/themes/dark/gmail-logo.png"
theme.office_icon            = "/usr/share/games/playonlinux/etc/install/applications-office.png"
theme.appli_icon      	     = "/usr/share/games/playonlinux/etc/onglet/application-x-executable.png"
theme.utils_icon      	     = "/usr/share/games/playonlinux/etc/install/applications-accessories.png"
theme.games_icon      	     = "/usr/share/games/playonlinux/etc/install/applications-games.png"
theme.other_icon      	     = "/usr/share/games/playonlinux/etc/install/applications-other.png"
theme.term_icon		     = "/usr/share/icons/gnome/16x16/apps/terminal.png"
theme.marble_icon	     = "/usr/share/icons/hicolor/16x16/apps/marble.png"
theme.quassel_icon	     = "/usr/share/apps/quassel/icons/oxygen/16x16/apps/quassel.png"
theme.ekiga_icon	     = "/usr/share/pixmaps/ekiga/ekiga.png"
theme.math_icon		     = "/usr/share/pixmaps/ooo-math.png"
theme.vlc_icon		     = "/usr/share/icons/hicolor/16x16/apps/vlc.png"
theme.writer_icon	     = "/usr/share/pixmaps/ooo-writer.png"
theme.color_icon	     = "/usr/share/icons/hicolor/16x16/apps/kcolorchooser.png"
theme.snap_icon	 	     = "/usr/share/icons/hicolor/16x16/apps/ksnapshot.png"
theme.ristretto_icon	     = "/usr/share/icons/hicolor/16x16/apps/ristretto.png"
theme.okular_icon	     = "/usr/share/icons/hicolor/16x16/apps/okular.png"
theme.gwen_icon		     = "/usr/share/icons/hicolor/16x16/apps/gwenview.png"
theme.reader_icon	     = "/usr/share/icons/oxygen/32x32/apps/acroread.png"
theme.kmplot_icon	     = "/usr/share/icons/nuvola/16x16/apps/kmplot.png"
theme.kalg_icon		     = "/usr/share/icons/hicolor/16x16/apps/kalgebra.png"
theme.kiten_icon	     = "/usr/share/icons/hicolor/16x16/apps/kiten.png"
theme.pidgin_icon	     = "/usr/share/icons/hicolor/16x16/apps/pidgin.png"
theme.firefox_icon	     = "/usr/share/pixmaps/firefox-bin-icon.png"
theme.chromium_icon	     = "/usr/share/pixmaps/chromium-bin.png"
theme.xpdf_icon		     = "/usr/share/pixmaps/xpdf.png"
theme.gimp_icon		     = "/usr/share/icons/hicolor/16x16/apps/gimp.png"
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
-- theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"
-- }}}

-- {{{ Layout
theme.layout_fairh           = "/usr/share/awesome/themes/sky/layouts/fairh.png"
theme.layout_fairv           = "/usr/share/awesome/themes/sky/layouts/fairv.png"
theme.layout_floating        = "/usr/share/awesome/themes/sky/layouts/floating.png"
theme.layout_magnifier       = "/usr/share/awesome/themes/sky/layouts/magnifier.png"
theme.layout_max             = "/usr/share/awesome/themes/sky/layouts/max.png"
theme.layout_fullscreen      = "/usr/share/awesome/themes/sky/layouts/fullscreen.png"
theme.layout_tilebottom      = "/usr/share/awesome/themes/sky/layouts/tilebottom.png"
theme.layout_tileleft        = "/usr/share/awesome/themes/sky/layouts/tileleft.png"
theme.layout_tile            = "/usr/share/awesome/themes/sky/layouts/tile.png"
theme.layout_tiletop         = "/usr/share/awesome/themes/sky/layouts/tiletop.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/zenburn/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_inactive.png"
-- }}}

return theme
