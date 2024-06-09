local wezterm = require("wezterm")
local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	if require("func").is_program_in_path("pwsh.exe") then
		table.insert(launch_menu, {
			label = "PowerShell",
			args = { "pwsh.exe", "-NoLogo" },
		})
	end
	table.insert(launch_menu, {
		label = "Windows PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})

	table.insert(launch_menu, {
		label = "Command Prompt",
		args = { "cmd.exe" },
	})
else
	if os.execute("zsh --version") then
		table.insert(launch_menu, {
			label = "Zsh",
			args = { "zsh" },
		})
	end
	table.insert(launch_menu, {
		label = "Bash",
		args = { "bash" },
	})
end

return {
	launch_menu = launch_menu,
}
