echo
echo "INSTALLING AUDIO COMPONENTS"
echo

PKGS=(
            'vlc'
	          'falkon'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Done!"
echo
