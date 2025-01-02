#!/usr/bin/bash

install-flatpak-apps() {
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

	flatpak install com.discordapp.Discord
	flatpak install com.discordapp.Discord
	flatpak install com.google.Chrome
	flatpak install com.slack.Slack
	flatpak install com.vivaldi.Vivaldi
	flatpak install org.angryip.ipscan
	flatpak install org.kicad.KiCad
	flatpak install org.libreoffice.LibreOffice
	flatpak install org.mozilla.firefox
}
