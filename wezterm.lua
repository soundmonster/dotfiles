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

-- local font = "Maple Mono"
-- local italic_font = font
-- local font_size = 12.5

-- local font = "Terminus (TTF)"
-- local italic_font = font
-- local font_size = 13.0

-- local font = "Departure Mono"
-- local italic_font = font
-- local font_size = 11.0

-- local font = "CommitMono"
-- local italic_font = font
-- local font_size = 12.5

local font = "JetBrains Mono"
local italic_font = font
local font_size = 12.5

-- local font = "Monaspace Neon" -- Neon Argon Xenon Radon Krypton
-- local italic_font = "Monaspace Radon"
-- local font_size = 12.5

-- local font = "Iosevka Nerd Font"
-- local italic_font = font
-- local font_size = 13.5
--
local color_scheme_name = scheme_for_appearance(wezterm.gui.get_appearance())
local color_scheme = wezterm.color.get_builtin_schemes()[color_scheme_name]

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local home_dir = os.getenv("HOME")
local function custom_tabline_pwd(tab)
	local opts = { max_length = 20 }
	local cwd = ''
	local cwd_uri = tab.active_pane.current_working_dir
	if cwd_uri then
		local file_path = cwd_uri.file_path
		if file_path == (home_dir .. '/') then
			cwd = '~'
		else
			cwd = file_path:match('([^/]+)/?$')
			if cwd and #cwd > opts.max_length then
				cwd = cwd:sub(1, opts.max_length - 1) .. '…'
			end
			if cwd:match('^sbs-') then
				cwd = cwd:sub(5) -- remove 'sbs-' prefix
			end
		end
	end
	return (cwd or '') .. ' '
end

tabline.setup({
	options = {
		theme = color_scheme_name,
		section_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thick,
			right = wezterm.nerdfonts.ple_left_half_circle_thick,
		},
		component_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thin,
			right = wezterm.nerdfonts.ple_left_half_circle_thin,
		},
		tab_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thick,
			right = wezterm.nerdfonts.ple_left_half_circle_thick,
		},
	},
	sections = {
		tabline_a = { 'mode' },
		tabline_b = { 'workspace' },
		tabline_c = { ' ' },
		tab_active = {
			'index',
			-- { 'parent', padding = 0 },
			-- '/',
			-- custom_tabline_pwd,
			{ 'cwd',     padding = { left = 0, right = 1 } },
			{ 'process', padding = { left = 0, right = 1 } },
			{ 'zoomed',  padding = 0 },
		},
		-- 			bg_color = color_scheme.ansi[4],
		-- 			fg_color = color_scheme.ansi[1],
		tab_inactive = {
			'index',
			-- custom_tabline_pwd,
			-- { custom_tabline_pwd, padding = { left = 0, right = 1 } },
			{ 'cwd',     padding = { left = 0, right = 1 } },
			{ 'process', padding = { left = 0, right = 1 } },
		},
		tabline_x = { 'ram', 'cpu' },
		tabline_y = { 'datetime', 'battery' },
		tabline_z = { 'hostname' },
	},
	extensions = {},
})

local config = {
	-- default_prog = { '/opt/homebrew/bin/zsh' },
	-- default_prog = { '/usr/local/bin/zsh' },
	font = wezterm.font({ family = font, weight = "Regular" }),
	font_rules = {
		{ intensity = "Bold", italic = false, font = wezterm.font({ family = font, weight = "Bold" }) },
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font({ family = italic_font, weight = "Bold", italic = true }),
		},
		{
			italic = true,
			font = wezterm.font({ family = italic_font, weight = "Regular", italic = true }),
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
	-- disabled in favor of tabline plugin
	-- colors = {
	-- 	tab_bar = {
	-- 		background = color_scheme.background,
	-- 		active_tab = {
	-- 			bg_color = color_scheme.ansi[],
	-- 			fg_color = color_scheme.ansi[1],
	-- 		},
	-- 		inactive_tab = {
	-- 			bg_color = color_scheme.background,
	-- 			fg_color = color_scheme.ansi[8],
	-- 		},
	-- 		new_tab = {
	-- 			bg_color = color_scheme.ansi[4],
	-- 			fg_color = color_scheme.ansi[1],
	-- 		},
	-- 	},
	-- },
	tab_bar_at_bottom = true,
	tab_max_width = 64,
	use_fancy_tab_bar = false,
	disable_default_key_bindings = true,
	-- timeout_milliseconds defaults to 1000 and can be omitted
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 5000 },
	debug_key_events = false,
	keys = {
		-- normal keys
		{ key = "v",          mods = "CMD",          action = act.PasteFrom("Clipboard") },
		{ key = "c",          mods = "CMD",          action = act.CopyTo("Clipboard") },
		{ key = "q",          mods = "CMD",          action = act.QuitApplication },
		{ key = "LeftArrow",  mods = "ALT",          action = act.SendString("\x1bb") },
		{ key = "RightArrow", mods = "ALT",          action = act.SendString("\x1bf") },
		{ key = "LeftArrow",  mods = "CMD",          action = act.SendKey({ key = "Home" }) },
		{ key = "RightArrow", mods = "CMD",          action = act.SendKey({ key = "End" }) },
		{ key = "+",          mods = "CMD|SHIFT",    action = act.IncreaseFontSize },
		{ key = "_",          mods = "CMD|SHIFT",    action = act.DecreaseFontSize },
		{ key = "0",          mods = "CMD",          action = act.ResetFontSize },
		-- tabs
		{ key = "c",          mods = "LEADER",       action = act.SpawnCommandInNewTab({ cwd = "$HOME" }) },
		{ key = "a",          mods = "LEADER",       action = act.ActivateLastTab },
		{ key = "n",          mods = "LEADER",       action = act.ActivateTabRelativeNoWrap(1) },
		{ key = "p",          mods = "LEADER",       action = act.ActivateTabRelativeNoWrap(-1) },
		{ key = "1",          mods = "LEADER",       action = act.ActivateTab(0) },
		{ key = "2",          mods = "LEADER",       action = act.ActivateTab(1) },
		{ key = "3",          mods = "LEADER",       action = act.ActivateTab(2) },
		{ key = "4",          mods = "LEADER",       action = act.ActivateTab(3) },
		{ key = "5",          mods = "LEADER",       action = act.ActivateTab(4) },
		{ key = "6",          mods = "LEADER",       action = act.ActivateTab(5) },
		{ key = "7",          mods = "LEADER",       action = act.ActivateTab(6) },
		{ key = "8",          mods = "LEADER",       action = act.ActivateTab(7) },
		{ key = "9",          mods = "LEADER",       action = act.ActivateTab(8) },
		{ key = "[",          mods = "LEADER",       action = act.MoveTabRelative(-1) },
		{ key = "]",          mods = "LEADER",       action = act.MoveTabRelative(1) },
		-- splits
		{ key = "%",          mods = "LEADER",       action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = '"',          mods = "LEADER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "h",          mods = "LEADER",       action = act.ActivatePaneDirection("Left") },
		{ key = "j",          mods = "LEADER",       action = act.ActivatePaneDirection("Down") },
		{ key = "k",          mods = "LEADER",       action = act.ActivatePaneDirection("Up") },
		{ key = "l",          mods = "LEADER",       action = act.ActivatePaneDirection("Right") },
		{ key = "LeftArrow",  mods = "LEADER",       action = act.ActivatePaneDirection("Left") },
		{ key = "DownArrow",  mods = "LEADER",       action = act.ActivatePaneDirection("Down") },
		{ key = "UpArrow",    mods = "LEADER",       action = act.ActivatePaneDirection("Up") },
		{ key = "RightArrow", mods = "LEADER",       action = act.ActivatePaneDirection("Right") },
		{ key = "{",          mods = "LEADER|SHIFT", action = act.RotatePanes("CounterClockwise") },
		{ key = "}",          mods = "LEADER|SHIFT", action = act.RotatePanes("Clockwise") },
		{ key = "z",          mods = "LEADER",       action = act.TogglePaneZoomState },
		-- when resizing, resize on the first keypress then activate layer
		{
			key = "h",
			mods = "LEADER|CTRL",
			action = act.Multiple({ act.AdjustPaneSize({ "Left", 1 }), activate_resize_keytable }),
		},
		{
			key = "LeftArrow",
			mods = "LEADER|CTRL",
			action = act.Multiple({ act.AdjustPaneSize({ "Left", 1 }), activate_resize_keytable }),
		},
		{
			key = "j",
			mods = "LEADER|CTRL",
			action = act.Multiple({ act.AdjustPaneSize({ "Down", 1 }), activate_resize_keytable }),
		},
		{
			key = "DownArrow",
			mods = "LEADER|CTRL",
			action = act.Multiple({ act.AdjustPaneSize({ "Down", 1 }), activate_resize_keytable }),
		},
		{
			key = "k",
			mods = "LEADER|CTRL",
			action = act.Multiple({ act.AdjustPaneSize({ "Up", 1 }), activate_resize_keytable }),
		},
		{
			key = "UpArrow",
			mods = "LEADER|CTRL",
			action = act.Multiple({ act.AdjustPaneSize({ "Up", 1 }), activate_resize_keytable }),
		},
		{
			key = "l",
			mods = "LEADER|CTRL",
			action = act.Multiple({ act.AdjustPaneSize({ "Right", 1 }), activate_resize_keytable }),
		},
		{
			key = "RightArrow",
			mods = "LEADER|CTRL",
			action = act.Multiple({ act.AdjustPaneSize({ "Right", 1 }), activate_resize_keytable }),
		},
		-- wezterm
		{ key = "v", mods = "LEADER", action = act.ActivateCopyMode },
		{ key = "/", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") },
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
		{
			key = "F",
			mods = "LEADER|SHIFT",
			action = wezterm.action.QuickSelectArgs({
				label = "select project filename",
				patterns = {
					"(\\/[a-z_\\-\\s0-9\\.]+)+\\.(ex|exs|eex|heex|js|json|rb|py|sh)",
				},
			}),
		},
		{ key = "d",     mods = "LEADER",       action = act.DetachDomain("CurrentPaneDomain") },
		{ key = "d",     mods = "LEADER|SHIFT", action = act.ShowDebugOverlay },
		{ key = "Space", mods = "LEADER",       action = act.ToggleFullScreen },
		-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
		{ key = "a",     mods = "LEADER|CTRL",  action = act.SendString("\x01") },
	},

	key_tables = {
		resize_pane = {
			{ key = "h",          mods = "CTRL",         action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "LeftArrow",  mods = "CTRL",         action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "j",          mods = "CTRL",         action = act.AdjustPaneSize({ "Down", 1 }) },
			{ key = "DownArrow",  mods = "CTRL",         action = act.AdjustPaneSize({ "Down", 1 }) },
			{ key = "k",          mods = "CTRL",         action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "UpArrow",    mods = "CTRL",         action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "l",          mods = "CTRL",         action = act.AdjustPaneSize({ "Right", 1 }) },
			{ key = "RightArrow", mods = "CTRL",         action = act.AdjustPaneSize({ "Right", 1 }) },
			-- Cancel the mode by pressing escape
			{ key = "Escape",     action = "PopKeyTable" },
		},
	},
}

tabline.apply_to_config(config)

return config
