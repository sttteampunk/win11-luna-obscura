-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Core Settings
config.front_end = "OpenGL"
config.max_fps = 120
config.default_cursor_style = "BlinkingBar"
config.animation_fps = 120
config.cursor_blink_rate = 500
config.term = "xterm-256color"
config.adjust_window_size_when_changing_font_size = false

-- Font Settings
config.font = wezterm.font("JetBrainsMono NFM")
config.font_size = 12.0
config.cell_width = 1.0

-- Window Styling
config.window_background_opacity = 0.9
config.win32_system_backdrop = "Auto"
config.prefer_egl = true
config.window_decorations = "NONE | RESIZE"
config.window_padding = {
	left = 12,
	right = 12,
	top = 12,
	bottom = 12,
}

-- Tab Bar Settings
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- Keymaps
config.keys = {
	{ key = "v", mods = "CTRL|SHIFT|ALT", action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }) },
	{ key = "h", mods = "CTRL|SHIFT|ALT", action = act.SplitPane({ direction = "Down", size = { Percent = 50 } }) },
	{ key = "U", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "I", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "O", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "P", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "9", mods = "CTRL", action = act.PaneSelect },
	{ key = "L", mods = "CTRL", action = act.ShowDebugOverlay },
	{ key = "+", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{
		key = "O",
		mods = "CTRL|ALT",
		action = wezterm.action_callback(function(window, _)
			local overrides = window:get_config_overrides() or {}
			if overrides.window_background_opacity == 1.0 then
				overrides.window_background_opacity = 0.7
			else
				overrides.window_background_opacity = 1.0
			end
			window:set_config_overrides(overrides)
		end),
	},
}

-- Color Palette
config.colors = {
	-- background = "rgba(0, 0, 0, 1)",
	background = "#0A0A0A",
	foreground = "#E5E7EB",

	cursor_bg = "#E5E7EB",
	cursor_border = "#E5E7EB",
	cursor_fg = "#151515",

	selection_bg = "#3F3F42",
	selection_fg = "#E5E7EB",

	-- The standard 8 ANSI colors
	ansi = {
		"#151515", -- black
		"#E5E7EB", -- red
		"#C0C0C1", -- green
		"#E5E7EB", -- yellow
		"#898F92", -- blue
		"#E5E7EB", -- purple
		"#E5E7EB", -- cyan
		"#E5E7EB", -- white
	},
	-- The bright 8 ANSI colors
	brights = {
		"#7B7B7B", -- bright black
		"#7B7B7B", -- bright red
		"#E5E7EB", -- bright green
		"#E5E7EB", -- bright yellow
		"#E5E7EB", -- bright blue
		"#E5E7EB", -- bright purple
		"#E5E7EB", -- bright cyan
		"#E5E7EB", -- bright white
	},

	tab_bar = {
		background = "rgba(0,0,0,0)",
		active_tab = {
			bg_color = "#000000",
			fg_color = "#E5E7EB",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = "#000000",
			fg_color = "#E5E7EB",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		new_tab = {
			bg_color = "#000000",
			fg_color = "#E5E7EB",
		},
	},
}

config.window_frame = {
	font = wezterm.font({ family = "JetBrainsMono NFP", weight = "Regular" }),
	active_titlebar_bg = "#000000",
}

config.default_prog = { "pwsh.exe", "-NoLogo", "-NoProfileLoadTime" }
config.initial_cols = 80

return config
