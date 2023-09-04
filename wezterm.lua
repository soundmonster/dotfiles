local wezterm = require("wezterm")
local act = wezterm.action

local activate_resize_keytable = act.ActivateKeyTable({
	name = "resize_pane",
	one_shot = false,
	timeout_milliseconds = 1000,
	until_unknown = true,
})

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		-- return "Catppuccin Mocha"
		return "tokyonight_moon"
	else
		-- return "Catppuccin Latte"
		return "tokyonight-day"
	end
end

local font = "JetBrains Mono"
local font_size = 12.5
-- local font = "Iosevka"
-- local font_size = 13.5
--
local color_scheme_name = scheme_for_appearance(wezterm.gui.get_appearance())
local color_scheme = wezterm.color.get_builtin_schemes()[color_scheme_name]

return {
	-- default_prog = { '/opt/homebrew/bin/zsh' },
	-- default_prog = { '/usr/local/bin/zsh' },
	font = wezterm.font({ family = font, weight = "Medium" }),
	font_rules = {
		{ intensity = "Bold", italic = false, font = wezterm.font({ family = font, weight = "ExtraBold" }) },
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font({ family = font, weight = "ExtraBold", italic = true }),
		},
	},
	underline_thickness = "200%",
	-- underline_position = "-2px",
	-- freetype_load_target = 'HorizontalLcd',
	font_size = font_size,
	cell_width = 1.0,
	line_height = 1.0,

	-- https://wezfurlong.org/wezterm/config/lua/config/term.html
	-- tempfile=$(mktemp) \
	-- && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo \
	-- && tic -x -o ~/.terminfo $tempfile \
	-- && rm $tempfile
	--
	term = "wezterm",

	audible_bell = "Disabled",
	visual_bell = {
		fade_in_duration_ms = 75,
		fade_out_duration_ms = 75,
		target = "CursorColor",
	},
	color_scheme = color_scheme_name,
	colors = {
		tab_bar = {
			background = color_scheme.background,
			active_tab = {
				bg_color = color_scheme.ansi[5],
				fg_color = color_scheme.ansi[1],
			},
			inactive_tab = {
				bg_color = color_scheme.background,
				fg_color = color_scheme.ansi[8],
			},
			new_tab = {
				bg_color = color_scheme.ansi[4],
				fg_color = color_scheme.ansi[1],
			},
		},
	},
	tab_bar_at_bottom = true,
	tab_max_width = 64,
	use_fancy_tab_bar = false,
	disable_default_key_bindings = true,
	-- timeout_milliseconds defaults to 1000 and can be omitted
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 5000 },
	debug_key_events = true,
	keys = {
		-- normal keys
		{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
		{ key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
		{ key = "q", mods = "CMD", action = act.QuitApplication },
		{ key = "LeftArrow", mods = "ALT", action = act.SendString("\x1bb") },
		{ key = "RightArrow", mods = "ALT", action = act.SendString("\x1bf") },
		{ key = "LeftArrow", mods = "CMD", action = act.SendKey({ key = "Home" }) },
		{ key = "RightArrow", mods = "CMD", action = act.SendKey({ key = "End" }) },
		{ key = "+", mods = "CMD|SHIFT", action = act.IncreaseFontSize },
		{ key = "_", mods = "CMD|SHIFT", action = act.DecreaseFontSize },
		{ key = "0", mods = "CMD", action = act.ResetFontSize },
		-- tabs
		{ key = "c", mods = "LEADER", action = act.SpawnCommandInNewTab({ cwd = "$HOME" }) },
		{ key = "a", mods = "LEADER", action = act.ActivateLastTab },
		{ key = "n", mods = "LEADER", action = act.ActivateTabRelativeNoWrap(1) },
		{ key = "p", mods = "LEADER", action = act.ActivateTabRelativeNoWrap(-1) },
		{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
		{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
		{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },
		{ key = "4", mods = "LEADER", action = act.ActivateTab(3) },
		{ key = "5", mods = "LEADER", action = act.ActivateTab(4) },
		{ key = "6", mods = "LEADER", action = act.ActivateTab(5) },
		{ key = "7", mods = "LEADER", action = act.ActivateTab(6) },
		{ key = "8", mods = "LEADER", action = act.ActivateTab(7) },
		{ key = "9", mods = "LEADER", action = act.ActivateTab(8) },
		{ key = "[", mods = "LEADER", action = act.MoveTabRelative(-1) },
		{ key = "]", mods = "LEADER", action = act.MoveTabRelative(1) },
		-- splits
		{ key = "%", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = '"', mods = "LEADER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
		{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
		{ key = "{", mods = "LEADER|SHIFT", action = act.RotatePanes("CounterClockwise") },
		{ key = "}", mods = "LEADER|SHIFT", action = act.RotatePanes("Clockwise") },
		{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
		-- when resizing, resize on the first keypress then activate layer
		{
			key = "h",
			mods = "LEADER|CTRL",
			action = act.Multiple({ act.AdjustPaneSize({ "Left", 1 }), activate_resize_keytable }),
		},
		{
			key = "j",
			mods = "LEADER|CTRL",
			action = act.Multiple({ act.AdjustPaneSize({ "Down", 1 }), activate_resize_keytable }),
		},
		{
			key = "k",
			mods = "LEADER|CTRL",
			action = act.Multiple({ act.AdjustPaneSize({ "Up", 1 }), activate_resize_keytable }),
		},
		{
			key = "l",
			mods = "LEADER|CTRL",
			action = act.Multiple({ act.AdjustPaneSize({ "Right", 1 }), activate_resize_keytable }),
		},
		-- wezterm
		{
			key = "u",
			mods = "LEADER",
			action = wezterm.action.QuickSelectArgs({
				label = "open url",
				patterns = {
					"https?://\\S+",
				},
				action = wezterm.action_callback(function(window, pane)
					local url = window:get_selection_text_for_pane(pane)
					wezterm.log_info("opening: " .. url)
					wezterm.open_with(url)
				end),
			}),
		},
		{
			key = "U",
			mods = "LEADER|SHIFT",
			action = wezterm.action.QuickSelectArgs({
				label = "select url",
				patterns = {
					"https?://\\S+",
				},
			}),
		},
		{ key = "d", mods = "LEADER", action = act.DetachDomain("CurrentPaneDomain") },
		{ key = "d", mods = "LEADER|SHIFT", action = act.ShowDebugOverlay },
		{ key = "Space", mods = "LEADER", action = act.ToggleFullScreen },
		-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
		{ key = "a", mods = "LEADER|CTRL", action = act.SendString("\x01") },
	},

	key_tables = {
		resize_pane = {
			{ key = "h", mods = "CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "j", mods = "CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },
			{ key = "k", mods = "CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "l", mods = "CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
			-- Cancel the mode by pressing escape
			{ key = "Escape", action = "PopKeyTable" },
		},
	},
}
