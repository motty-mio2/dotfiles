local wezterm = require("wezterm")

clm = require("launcher").launch_menu

local default_prog = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	if require("func").is_program_in_path("pwsh.exe") then
		default_prog = { "pwsh.exe", "-NoLogo", "-NoExit", "-WorkingDirectory", "~" }
	else
		default_prog = { "powershell.exe", "-NoLogo", "-NoExit" }
	end
else
	if os.execute("zsh --version") then
		default_prog = { "zsh" }
	else
		default_prog = { "bash" }
	end
end

return {
	font = wezterm.font("HackGen Console"), -- 自分の好きなフォントいれる
	use_ime = true,
	font_size = 12.0,
	color_scheme = "OneHalfDark",
	hide_tab_bar_if_only_one_tab = true,
	adjust_window_size_when_changing_font_size = false,
	keys = require("keybinds").keys,
	disable_default_key_bindings = true,
	default_prog = default_prog,
	launch_menu = clm,
}
