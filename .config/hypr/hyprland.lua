---@module 'hl'

--------------------------------------------------------------------------------
-- VARIABLES & ENVIRONMENT
--------------------------------------------------------------------------------
local terminal = "kitty"
local browser = "brave"
local fileManager = "Thunar"
local mainMod = "SUPER"

hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("HYPRSHOT_DIR", "/home/fuge/docs/pictures/screenshots")
hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)

--------------------------------------------------------------------------------
-- MONITORS
--------------------------------------------------------------------------------
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

--------------------------------------------------------------------------------
-- CORE CONFIGURATION
--------------------------------------------------------------------------------
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 9,
		border_size = 2,
		resize_on_border = true,
		allow_tearing = true,
		layout = "dwindle",
		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
	},
	decoration = {
		rounding = 5,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
	animations = {
		enabled = true,
		bezier = {
			{ name = "myBezier", x1 = 0.02, y1 = 0.93, x2 = 0.07, y2 = 1.02 },
		},
		animation = {
			{ name = "windows", enabled = true, speed = 7, curve = "myBezier" },
			{ name = "windowsOut", enabled = true, speed = 7, curve = "default", style = "popin 80%" },
			{ name = "border", enabled = true, speed = 10, curve = "default" },
			{ name = "borderangle", enabled = true, speed = 8, curve = "default" },
			{ name = "fade", enabled = true, speed = 7, curve = "default" },
			{ name = "workspaces", enabled = true, speed = 6, curve = "default" },
		},
	},
	dwindle = {
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
	},
	input = {
		kb_layout = "jp",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

--------------------------------------------------------------------------------
-- KEYBINDINGS
--------------------------------------------------------------------------------

-- System
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("~/.config/hypr/powermenu.sh"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("uwsm app -- hyprlock"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("uwsm stop"))

-- Quick Actions
hl.bind(mainMod .. " + X", hl.dsp.window.close())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("hyprctl dispatch fullscreen 1"))
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("uwsm app -- ~/.config/waybar/scripts/launch.sh"))

-- Applications
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("uwsm app -- " .. terminal))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("uwsm app -- fuzzel"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("uwsm app -- " .. fileManager))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("uwsm app -- " .. browser))

-- Screenshots
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("uwsm app -- hyprshot -m output"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("uwsm app -- hyprshot -m window"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("uwsm app -- hyprshot -m region"))

-- Move Focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move Window
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- Workspaces (1 - 10)
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "e-1" }))

-- Move Workspace to Monitor
hl.bind(mainMod .. " + SHIFT + CONTROL + left", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + CONTROL + right", hl.dsp.workspace.move({ monitor = "r" }))

-- Special Workspace (Scratchpad)
hl.bind(mainMod .. " + B", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse Binds
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Active Window Resizing
hl.bind("ALT + LEFT", hl.dsp.window.resize({ x = -50, y = 0 }))
hl.bind("ALT + RIGHT", hl.dsp.window.resize({ x = 50, y = 0 }))
hl.bind("ALT + UP", hl.dsp.window.resize({ x = 0, y = -50 }))
hl.bind("ALT + DOWN", hl.dsp.window.resize({ x = 0, y = 50 }))

-- Audio Controls
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1.2 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))

--------------------------------------------------------------------------------
-- AUTOSTART
--------------------------------------------------------------------------------
hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm app -- " .. terminal)
	hl.exec_cmd("uwsm app -- " .. browser)
	hl.exec_cmd("uwsm app -- fcitx5 -d")
	hl.exec_cmd("uwsm app -- nm-applet")
	hl.exec_cmd("uwsm app -- wl-paste --type text --watch cliphist store")
	hl.exec_cmd("uwsm app -- wl-paste --type image --watch cliphist store")
end)
