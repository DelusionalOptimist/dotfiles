
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
eval $(keychain --eval --quiet id_ed25519)
eval $(keychain --eval --quiet dovm1)
