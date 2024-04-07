FROM quay.io/fedora-ostree-desktops/kinoite:rawhide

# Add rpm-fusion repository - https://rpmfusion.org/Howto/OSTree
RUN rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Add some basic tools
RUN rpm-ostree install btop ncdu restic rclone

# VM stuff
RUN rpm-ostree install libvirt virt-manager

# Steam [rpm-fusion]
RUN rpm-ostree install steam

# HW codecs [rpm-fusion]
# TODO: verify what's wrong
#RUN rpm-ostree override remove mesa-va-drivers --install mesa-va-drivers-freeworld
# There is no mesa-vdpau-drivers package installed on kinoite:40
#RUN rpm-ostree override remove mesa-vdpau-drivers --install mesa-vdpau-drivers-freeworld

# Tailscale - https://github.com/tailscale/tailscale/issues/6761
RUN wget https://pkgs.tailscale.com/stable/fedora/tailscale.repo -P /etc/yum.repos.d/
RUN sed -i 's/repo_gpgcheck=1/repo_gpgcheck=0/' /etc/yum.repos.d/tailscale.repo
RUN rpm-ostree install tailscale

# Copy custom configs
COPY files/etc/ /etc
