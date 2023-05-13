local wezterm = require 'wezterm';

if wezterm.target.target_triple == 'x86_64-pc-windows-msvc' then
    local default_prog = {"pwsh.exe", "-NoLogo", "-NoExit"}
else
    local default_prog = {"/usr/bin/zsh"}
end

return {
    font = wezterm.font("HackGen Console"), -- 自分の好きなフォントいれる
    use_ime = true,
    font_size = 12.0,
    color_scheme = "OneHalfDark",
    hide_tab_bar_if_only_one_tab = true,
    adjust_window_size_when_changing_font_size = false,
    default_prog = default_prog,
    keys = require("keybinds").keys,
    disable_default_key_bindings = true
}
