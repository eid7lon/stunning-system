#!/usr/bin/env bash
echo
echo "Installing Base System"
echo

PKGS=(
	'librewolf-bin'
)

for PKG in "${PKGS}"; do
	echo "installing: ${PKG}"
	yes | yay -S "$PKG" --answerdiff=None --answerclean=None --sudoloop --needed
done

echo
echo "done"
echo
