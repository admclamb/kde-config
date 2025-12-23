#!/usr/bin/env bash
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "Run as root"
    exit 1
fi

ech "Installing etckeeper..."
pacman -Syu --noconfirm etckeeper git

ETC_CONF="/etc/etckeeper/etckeeper.conf"

echo "Configuring etckeeper..."
sed -i 's/^#VCS=.*/VCS="git"/' "$ETC_CONF"
sed -i 's/^#PUSH_REMOTE=.*/PUSH_REMOTE=""/' "$ETC_CONF"

echo "Initializing etckeeper..."
if [[ ! -d /etc/.git ]]; then
    etckeeper init
    etckeeper commit "Initial commit of /etc"
else
    echo "/etc already under etckeeper control"
fi

echo "Enabling pacman hook..."
systemctl enable --now etckeeper.timer

echo "etckeeper setup complete"