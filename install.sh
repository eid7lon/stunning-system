#!/usr/bin/env bash
echo
echo "Installing Base Apps"
echo

PKGS=(
	'firefox'
	'flameshot'
	'joplin'
	'librewolf-bin'
	'mullvad-vpn'
	'okular'
)

for PKG in "${PKGS}"; do
	echo "installing: ${PKG}"
	yes | yay -S "$PKG" --answerdiff=None --answerclean=None --needed
done

echo
echo "done"
echo
