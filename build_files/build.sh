#!/bin/bash

set -ouex pipefail

# set default wallpaper
ln -sf /usr/share/wallpapers/AmogOS-original.png /usr/share/backgrounds/default.png
ln -sf /usr/share/wallpapers/DankMode.png /usr/share/backgrounds/default-dark.png

# /usr/share/sddm/themes/01-breeze-fedora/theme.conf uses default.jxl for the background
ln -sf /usr/share/backgrounds/default.png /usr/share/backgrounds/default.jxl
ln -sf /usr/share/backgrounds/default-dark.png /usr/share/backgrounds/default-dark.jxl

ln -sf /usr/share/backgrounds/usus/usus.xml /usr/share/backgrounds/default.xml


# splash screen
ln -sf /usr/share/pixmaps/imposter.svg /usr/share/plasma/look-and-feel/dev.getaurora.aurora.desktop/contents/icons/aurora-logo.svg
gzip -c /usr/share/pixmaps/imposter.svg > /usr/share/plasma/look-and-feel/dev.getaurora.aurora.desktop/contents/splash/images/aurora_logo.svgz

sed -i 's|https://getaurora.dev|https://getsussy.lol|g' /etc/os-release
sed -i 's|https://docs.getaurora.dev|https://glorp.ihatethis.getaurora.dev|g' /etc/os-release
sed -i 's|https://github.com/ublue-os/aurora|https://github.com/renner0e/usus|g' /etc/os-release


# copy pasted initramfs script
KERNEL_SUFFIX=""

QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')"
/usr/bin/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible -v --add ostree -f "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"
chmod 0600 "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"

