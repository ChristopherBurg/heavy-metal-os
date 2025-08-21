#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# The following package are installed.
#
# input-remapper: Allows me to remap button on my trackballs.
dnf5 install --setopt=install_weak_deps=False -y \
    distrobox \
    input-remapper \
    libvirt \
    libvirt-daemon-kvm

# I use the Firefox flatpak so the system installed version is unnecessary.
dnf5 remove -y \
    firefox \
    firefox-langpacks

flatpak -y uninstall \
    org.gnome.Calculator \
    org.gnome.Characters \
    org.gnome.Calendar

# Enable the Flathub flatpak repository. Trying to enable third-part repositories
# inside of a virtual machine seems to lock up Silverblue on my system so I just
# brute force it here.
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket

systemctl enable input-remapper.service
systemctl enable libvirtd.service
