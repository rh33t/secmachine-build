local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Appearance
config.font = wezterm.font_with_fallback({
	"JetBrainsMono NF",
	"Consolas",
	"Monaco",
})
config.font_size = 14
config.color_scheme = "Dracula"
config.window_decorations = "NONE"
config.tab_bar_at_bottom = false
config.enable_tab_bar = false

-- Default shell
config.default_prog = { "zsh", "-c", "tmux attach || tmux new-session -s daily" }

-- Keybindings
config.keys = {
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SendKey({ key = "LeftArrow", mods = "CTRL|SHIFT" }),
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SendKey({ key = "RightArrow", mods = "CTRL|SHIFT" }),
	},
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = wezterm.action.SendKey({ key = "UpArrow", mods = "CTRL|SHIFT" }) },
	{
		key = "DownArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SendKey({ key = "DownArrow", mods = "CTRL|SHIFT" }),
	},
}

-- config.colors = theme.colors()

-- config.window_frame = theme.window_frame()

-- disable gpu rendering for vm
config.front_end = "Software"

return config
