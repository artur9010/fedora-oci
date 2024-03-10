FROM quay.io/fedora-ostree-desktops/kinoite:40

# Add some basic tools
RUN rpm-ostree install btop ncdu