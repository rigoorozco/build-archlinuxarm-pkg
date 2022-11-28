FROM archlinux:base-devel as builder

MAINTAINER Chris Fordham <chris@fordham.id.au>

COPY sudoers.d/build /etc/sudoers.d/

RUN pacman-key --init && \
    pacman-db-upgrade && \
    update-ca-trust && \
    pacman -Syyu --noconfirm base-devel git archlinux-keyring curl tar reflector \
    aarch64-linux-gnu-gcc devtools namcap xmlto docbook-xsl inetutils bc uboot-tools \
    dtc ccache && \
    useradd -d /usr/local/build -m -G wheel build && \
    # we do this mostly just because a lot of mirrors are unreliable
    reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

USER build

RUN cd /tmp && \
    curl https://aur.archlinux.org/cgit/aur.git/snapshot/aurman.tar.gz > aurman.tar.gz && \
    tar zxvf aurman.tar.gz && \
    cd aurman && \
    gpg --recv-keys 4C3CE98F9579981C21CA1EC3465022E743D71E39 && \
    makepkg -si --noconfirm --needed
    
FROM builder
VOLUME /usr/local/build/src
USER build
RUN mkdir -p "$HOME/src"
WORKDIR /usr/local/build/src
COPY docker-entrypoint.sh /opt/bin/docker-entrypoint.sh
ENTRYPOINT ["/opt/bin/docker-entrypoint.sh"]
CMD sudo -E pacman -Sy && \
    makepkg -sfc --noconfirm --needed && \
    makepkg --printsrcinfo > .SRCINFO
