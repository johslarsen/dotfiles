import System.Exit
import System.IO
import Graphics.X11.Xlib
import Graphics.X11.ExtraTypes.XF86

import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.LayoutHints
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile

import Control.Monad (liftM2)

import qualified Data.Map as M
import qualified XMonad.StackSet as W
 
main = xmonad =<< statusBar "/usr/bin/xmobar ~/.xmobarrc" myPP toggleBarKey (withUrgencyHook NoUrgencyHook $ def)
		{ manageHook = myManageHook <+> manageHook def
		, layoutHook = myLayoutHook
		, modMask = mod4Mask     -- Rebind Mod to the Super key
		, workspaces = myWorkspaces
		, keys = myKeys
		, terminal = "xterm"
		, focusFollowsMouse = True
		, normalBorderColor = "#444444"
		, focusedBorderColor = "#00ff00"
		, startupHook = setWMName "LG3D" -- hack so that java GUI applications are more cooperative
		}

toggleBarKey XConfig {XMonad.modMask = modMask} = (modMask .|. altMask, xK_b)

myWorkspaces = ["|:mon", "1",     "2",    "3",     "4",     "5",
                         "Q",     "Web",  "Email", "Rsh",   "T",
                         "Audio", "Sys",  "Doc",   "File",  "G",
                         "Zoom",  "Xfer", "Chat",  "Video", "B"]
myManageHook = composeAll
		[ className =? "Thunderbird"      --> doShift "Email" 

		, className =? "Skype"            --> doShift "Chat" 

		, className =? "Firefox"          --> doShift "Web" 
		, className =? "Opera"            --> doShift "Web" 
		, className =? "Chromium-browser" --> doShift "Web"  -- ubuntu
		, className =? "Chromium"         --> doShift "Web"  -- arch

		, className =? "Plugin-container" --> viewShift "Zoom"  -- firefox flash fullscreen
		, className =? "Exe" --> viewShift "Zoom"  -- chromium flash fullscreen
		, className =? "Operapluginwrapper-native" --> viewShift "Zoom"  -- opera flash fullscreen


		, className =? "Pavucontrol"      --> doShift "Audio" 

		, className =? "Vlc"              --> viewShift "Video" 
		, className =? "mpv"              --> viewShift "Video"

		, className =? "Evince"           --> viewShift "Doc" 
		, className =? "Zathura"          --> viewShift "Doc" 

		, className =? "Gimp"             --> ask >>= doF . W.sink
		]
	where
		viewShift = doF . liftM2 (.) W.greedyView W.shift

myLayoutHook = avoidStruts
	$ onWorkspace "Web"    (rtall 0.5 ||| full  ||| wide)
	$ onWorkspace "Email"  (wide      ||| tall  ||| full)
	$ onWorkspace "Audio"  (rtall rgr ||| wide  ||| full)
	$ onWorkspace "Doc"    (full      ||| tall  ||| wide)
	$ onWorkspace "Fle"    (wide      ||| tall  ||| full)
	$ onWorkspace "Zoom"   (full      ||| tall  ||| wide)
	$ onWorkspace "Xfer"   (wide      ||| tall  ||| full)
	$ onWorkspace "Video"  (full      ||| vwide ||| tall)
	$                      (tall      ||| vwide ||| full)
	where
		nmaster = 1
		delta = 0.01
		gr = toRational (2/(1+sqrt(5)::Double)) -- golden ratio
		rgr = 1-gr -- reverse golden ratio
		vwr = 0.915 -- usefull very wide ratio, giving approx 5 lines (12px) terminal below large window on WIDTH*1200
		rtall r = smartBorders
			$ Tall nmaster delta r
		rwide r = Mirror $ rtall r
		tall = rtall gr
		wide = rwide gr
		vwide = rwide vwr
		full = noBorders
			$ Full

myPP = xmobarPP
	{ ppSep = " "
	, ppCurrent = xmobarColor "#cccc00" "" . wrap "[" "]"
	, ppVisible = xmobarColor "#00cc00" "" .wrap "(" ")"
	, ppUrgent = xmobarColor "#cc0000" "" . wrap "*" "*"
	, ppTitle = xmobarColor "#00cc00" "" . trim
	, ppLayout = xmobarColor "#cc00cc" "" . (\x -> case x of --- compact layout indicator
		"Full" -> "^"
		"Mirror Tall" -> "-"
		"Tall" -> "|")
	, ppExtras = [logWindowCount]
	, ppOrder = \(ws:l:t:e:_) -> [ws,l,e,t]
	}

logWindowCount = withWindowSet $
	return . Just . xmobarColor "#cc00cc" "" . show . length . W.index

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
altMask = mod1Mask
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

	[ ((modm                          .|.altMask, xK_s     ), spawn $ XMonad.terminal conf) -- launch a terminal
	, ((modm              .|.shiftMask.|.altMask, xK_s     ), spawn "PATH=$PATH:$HOME/bin:$HOME/.bin dmenu_run") -- launch dmenu

	, ((modm                                    , xK_space ), sendMessage NextLayout) -- Rotate through the available layout algorithms
	, ((modm              .|.shiftMask          , xK_space ), setLayout $ XMonad.layoutHook conf) --  Reset the layouts on the current workspace to default

	, ((modm                          .|.altMask, xK_c     ), kill) -- close focused window
	, ((modm                          .|.altMask, xK_n     ), refresh) -- Resize viewed windows to the correct size
	, ((modm                          .|.altMask, xK_t     ), withFocused $ windows . W.sink) -- Push window back into tiling

	, ((modm                          .|.altMask, xK_w     ), windows W.focusMaster) -- Move focus to the master window
	, ((modm              .|.shiftMask.|.altMask, xK_w     ), windows W.swapMaster) -- Swap the focused window and the master window

	, ((modm                                    , xK_Tab   ), windows W.focusDown) -- Move focus to the next window
	, ((modm              .|.shiftMask          , xK_Tab   ), windows W.focusUp  ) -- Move focus to the previous window
	, ((modm                                    , xK_j     ), windows W.focusDown) -- Move focus to the next window
	, ((modm                                    , xK_k     ), windows W.focusUp  ) -- Move focus to the previous window
	, ((modm                          .|.altMask, xK_j     ), windows W.swapDown  ) -- Swap the focused window with the next window
	, ((modm                          .|.altMask, xK_k     ), windows W.swapUp    ) -- Swap the focused window with the previous window

	, ((modm                                    , xK_h     ), sendMessage Shrink) -- Shrink the master area
	, ((modm                                    , xK_l     ), sendMessage Expand) -- Expand the master area
	, ((modm                          .|.altMask, xK_h     ), sendMessage MirrorShrink)
	, ((modm                          .|.altMask, xK_l     ), sendMessage MirrorExpand)

	, ((modm                                    , xK_comma ), sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area
	, ((modm                                    , xK_period), sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area

	, ((modm.|.controlMask                      , xK_Tab   ), nextWS) -- shift to next workspace
	, ((modm.|.controlMask.|.shiftMask          , xK_Tab   ), prevWS) -- shift to previous workspace

	, ((modm                          .|.altMask, xK_q     ), spawn "xmonad --recompile; xmonad --restart") -- Restart xmonad
	, ((modm.|.controlMask            .|.altMask, xK_q     ), io (exitWith ExitSuccess)) -- Quit xmonad

	, ((modm                                    , xK_Print ), spawn "scrot") -- screenshot
	, ((modm              .|.shiftMask          , xK_Print ), spawn "sleep 0.2; scrot -s") -- screenshot for window clicked on

	, ((modm                          .|.altMask, xK_m     ), spawn "synclient TouchpadOff=$(synclient -l | grep -c 'TouchpadOff.*=.*0')") -- toggle touchpad

	, ((modm                          .|.altMask, xK_z     ), spawn "xscreensaver-command -lock") -- lock screen

	, ((modm                                    , xK_Down  ), spawn "~/.bin/xclasskeys.sh Zathura Page_Down") -- presenter next
	, ((modm                                    , xK_Right ), spawn "~/.bin/xclasskeys.sh Zathura Page_Down") -- presenter next
	, ((modm                                    , xK_Left  ), spawn "~/.bin/xclasskeys.sh Zathura Page_Up") -- presenter previous
	, ((modm                                    , xK_Up    ), spawn "~/.bin/xclasskeys.sh Zathura Page_Up") -- presenter previous

	, ((modm.|.controlMask                      , xK_p     ), spawn "mpc &>/dev/null toggle") -- mpd play/pause
	, ((modm.|.controlMask                      , xK_space ), spawn "mpc &>/dev/null toggle") -- mpd play/pause
	, ((0, xF86XK_AudioPlay                                ), spawn "mpc &>/dev/null toggle") -- mpd play/pause
	, ((0, xF86XK_AudioPause                               ), spawn "mpc &>/dev/null pause") -- mpd play/pause
	, ((modm.|.controlMask                      , xK_h     ), spawn "mpc &>/dev/null prev") -- mpd previous song
	, ((0, xF86XK_AudioPrev                                ), spawn "mpc &>/dev/null prev") -- mpd previous song
	, ((modm.|.controlMask                      , xK_j     ), spawn "mpc &>/dev/null seek -2%") -- mpd seek backward
	, ((modm.|.controlMask                      , xK_k     ), spawn "mpc &>/dev/null seek +2%") -- mpd seek forward
	, ((modm.|.controlMask                      , xK_l     ), spawn "mpc &>/dev/null next") -- mpd next song
	, ((0, xF86XK_AudioNext                                ), spawn "mpc &>/dev/null next") -- mpd next song
	, ((0, xF86XK_AudioStop                                ), spawn "mpc &>/dev/null stop") -- mpd stop song
	, ((modm.|.controlMask                      , xK_minus ), spawn "mpc &>/dev/null volume -4") -- volume decrease
	, ((modm.|.controlMask                      , xK_plus  ), spawn "mpc &>/dev/null volume +4") -- volume increase
	, ((modm.|.controlMask                      , xK_r     ), spawn "mpc &>/dev/null repeat") -- mpd toggle repeat mode
	, ((modm.|.controlMask                      , xK_z     ), spawn "mpc &>/dev/null random") -- mpd toggle random mode
	, ((modm.|.controlMask                      , xK_y     ), spawn "mpc &>/dev/null single") -- mpd toggle single repeat mode
	, ((modm.|.controlMask            .|.altMask, xK_r     ), spawn "mpc &>/dev/null consume") -- mpd toggle consume mode, remove song from playlist after completion
	, ((modm.|.controlMask                      , xK_s     ), spawn "~/.bin/resync_bluez_sound_card.sh")
	, ((modm.|.controlMask                      , xK_v     ), spawn "~/.bin/mclip") -- play video URL in clipboard

	, ((modm              .|.shiftMask.|.altMask, xK_0     ), spawn "~/.bin/dual_screen_put_primary_in_relation_to_secondary.sh o")
	, ((modm              .|.shiftMask.|.altMask, xK_y     ), spawn "~/.bin/dual_screen_put_primary_in_relation_to_secondary.sh lt")
	, ((modm              .|.shiftMask.|.altMask, xK_u     ), spawn "~/.bin/dual_screen_put_primary_in_relation_to_secondary.sh al")
	, ((modm              .|.shiftMask.|.altMask, xK_i     ), spawn "~/.bin/dual_screen_put_primary_in_relation_to_secondary.sh ar")
	, ((modm              .|.shiftMask.|.altMask, xK_o     ), spawn "~/.bin/dual_screen_put_primary_in_relation_to_secondary.sh rt")
	, ((modm              .|.shiftMask.|.altMask, xK_h     ), spawn "~/.bin/dual_screen_put_primary_in_relation_to_secondary.sh lc")
	, ((modm              .|.shiftMask.|.altMask, xK_k     ), spawn "~/.bin/dual_screen_put_primary_in_relation_to_secondary.sh ac")
	, ((modm              .|.shiftMask.|.altMask, xK_j     ), spawn "~/.bin/dual_screen_put_primary_in_relation_to_secondary.sh bc")
	, ((modm              .|.shiftMask.|.altMask, xK_l     ), spawn "~/.bin/dual_screen_put_primary_in_relation_to_secondary.sh rc")
	, ((modm              .|.shiftMask.|.altMask, xK_n     ), spawn "~/.bin/dual_screen_put_primary_in_relation_to_secondary.sh lb")
	, ((modm              .|.shiftMask.|.altMask, xK_m     ), spawn "~/.bin/dual_screen_put_primary_in_relation_to_secondary.sh bl")
	, ((modm              .|.shiftMask.|.altMask, xK_comma ), spawn "~/.bin/dual_screen_put_primary_in_relation_to_secondary.sh br")
	, ((modm              .|.shiftMask.|.altMask, xK_period), spawn "~/.bin/dual_screen_put_primary_in_relation_to_secondary.sh rb")

	, ((0, xF86XK_MonBrightnessUp)                          , spawn "xbacklight -time 0 +9")
	, ((0, xF86XK_MonBrightnessDown)                        , spawn "xbacklight -time 0 -9")

	, ((0, xF86XK_AudioMute)                                , spawn "~/.bin/pa-vol.sh mute"                              )
	, ((modm                          .|.altMask, xK_space) , spawn "~/.bin/pa-vol.sh mic"                               )
	, ((0, xF86XK_AudioLowerVolume)                         , spawn "~/.bin/pa-vol.sh minus"                             )
	, ((0, xF86XK_AudioRaiseVolume)                         , spawn "~/.bin/pa-vol.sh plus"                              )

	, ((0, xF86XK_KbdLightOnOff)                            , spawn "sudo /usr/local/lib/backlight/backlight_kbd.sh toggle")
	, ((0, xF86XK_KbdBrightnessUp)                          , spawn "sudo /usr/local/lib/backlight/backlight_kbd.sh +"     )
	, ((0, xF86XK_KbdBrightnessDown)                        , spawn "sudo /usr/local/lib/backlight/backlight_kbd.sh -"     )

	, ((0, xF86XK_Display)                                  , spawn "xrandr --auto"                                            )
	, ((modm, xK_p)                                         , spawn "xrandr --auto"                                            ) -- Stupid DELL BIOS sending this for fn+f8 (earlier xF86XK_Display)

	, ((0, xF86XK_Eject)                                    , spawn "eject"                                                    )
	]
	++
	-- mod-KEY, Switch to workspace N
	-- mod-shift-KEY, Move client to workspace N
	-- mod-shift-ctrl-KEY, Move client to workspace N and switch to workspace N
	[((m .|. modm, k), windows $ f i)
		| (i, k) <- zip (XMonad.workspaces conf) ([xK_bar]++[xK_1       ..       xK_5]++
		                                                    [xK_q,xK_w,xK_e,xK_r,xK_t]++
		                                                    [xK_a,xK_s,xK_d,xK_f,xK_g]++
		                                                    [xK_z,xK_x,xK_c,xK_v,xK_b])
		, (f, m) <- [(W.greedyView, 0)
		            ,(W.shift, shiftMask)
		            ,(\i -> W.greedyView i . W.shift i, shiftMask .|. controlMask)]]
	++
	-- mod-alt-{1,2,3}, Switch to physical/Xinerama screens 1, 2, or 3
	-- mod-alt-shift-{1,2,3}, Move client to screen 1, 2, or 3
	[((m .|. modm .|. altMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
		| (key, sc) <- zip [xK_1, xK_2, xK_3] [0..]
		, (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
