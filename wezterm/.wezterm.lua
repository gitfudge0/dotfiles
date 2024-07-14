local wezterm = require("wezterm")

return {
	-- color_scheme = 'termnial.sexy',
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,
	use_fancy_tab_bar = false,
	font_size = 16.0,
	font = wezterm.font("JetBrains Mono"),
	macos_window_background_blur = 64,

	-- colors = {
	-- 	tab_bar = {
	-- 		background = "rgba(0, 0, 0, 0.1)",
	-- 	},
	-- },

	tab_max_width = 32,

	window_background_opacity = 0.9,
	window_decorations = "RESIZE",
	keys = {
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
	},
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
