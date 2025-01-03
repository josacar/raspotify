.PHONY: all armhf arm64 amd64 clean distclean
.DEFAULT_GOAL := all

RASPOTIFY_AUTHOR?=Kim Tore Jensen <kimtjen@gmail.com>

armhf:
	podman build -t raspotify .
	podman run \
			--rm \
			--volume "$(CURDIR):/mnt/raspotify" \
			--env PERMFIX_UID="$$(id -u)" \
			--env PERMFIX_GID="$$(id -g)" \
			--env RASPOTIFY_AUTHOR="$(RASPOTIFY_AUTHOR)" \
			--env ARCHITECTURE="armhf" \
		raspotify /mnt/raspotify/build.sh

arm64:
	podman build -t raspotify .
	podman run \
			--rm \
			--volume "$(CURDIR):/mnt/raspotify" \
			--env PERMFIX_UID="$$(id -u)" \
			--env PERMFIX_GID="$$(id -g)" \
			--env RASPOTIFY_AUTHOR="$(RASPOTIFY_AUTHOR)" \
			--env ARCHITECTURE="arm64" \
		raspotify /mnt/raspotify/build.sh

amd64:
	podman build -t raspotify .
	podman run \
			--rm \
			--volume "$(CURDIR):/mnt/raspotify" \
			--env PERMFIX_UID="$$(id -u)" \
			--env PERMFIX_GID="$$(id -g)" \
			--env RASPOTIFY_AUTHOR="$(RASPOTIFY_AUTHOR)" \
			--env ARCHITECTURE="amd64" \
		raspotify /mnt/raspotify/build.sh

all:
	podman build -t raspotify .
	podman run \
			--rm \
			--volume "$(CURDIR):/mnt/raspotify" \
			--env PERMFIX_UID="$$(id -u)" \
			--env PERMFIX_GID="$$(id -g)" \
			--env RASPOTIFY_AUTHOR="$(RASPOTIFY_AUTHOR)" \
			--env ARCHITECTURE="all" \
		raspotify /mnt/raspotify/build.sh

clean:
	rm -rf *.deb librespot asound-conf-wizard raspotify/usr/bin/librespot raspotify/usr/share raspotify/DEBIAN/control apt-repo

distclean: clean
	podman rmi -f raspotify || true
