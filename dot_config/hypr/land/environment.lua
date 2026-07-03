-----------------
--- AUTOSTART ---
-----------------
hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user start hyprland-session.target")
	hl.exec_cmd("/usr/libexec/polkit-agent-helper-1")
	hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
	hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"')
end)

-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

hl.config({
	env = {
		"XCURSOR_SIZE,16",
		"HYPRCURSOR_SIZE,16",
		-- "XDG_DATA_DIRS,/usr/local/share:/usr/share:$HOME/.local/state/nix/profiles/profile/share/:/nix/var/nix/profiles/default/share:/var/lib/snapd/desktop",
		"QT_QPA_PLATFORMTHEME,qt6ct",
		"QT_QPA_PLATFORM,wayland",
		"QT_STYLE_OVERRIDE,kvantum",
		"QT_QPA_PLATFORMTHEME,qt5ct",
	},
})

-------------------
--- PERMISSIONS ---
-------------------

hl.permission({ binary = "/usr/(bin|local/bin)/grim", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/lib/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/bin/hyprpm", type = "plugin", mode = "allow" })
