FROM debian:bullseye

LABEL version="1.0"
LABEL description="Local NetHackWiki Mirror"
LABEL maintainer="tmp6154@yandex.ru"

ENV USER "kiwixserve"

# Install build tools

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install wget -y
    
# Make a new user

RUN groupadd -g 1000 $USER && useradd -u 1000 -g $USER $USER && \
    mkdir -p /home/$USER && chown $USER:$USER /home/$USER && \
    chmod 755 /home/$USER
USER $USER
WORKDIR /home/$USER

# Install Kiwix-Serve

RUN ARCH=`dpkg --print-architecture` ; \
    KIWIX_ARCH="unknown" ; \
    if [ "$ARCH" = "amd64" ] ; then \
	KIWIX_ARCH="x86_64" ; \
    elif [ "$ARCH" = "i386" ] ; then \
	KIWIX_ARCH="i586" ; \
    elif echo "$ARCH" | grep -q "arm" ; then \
        KIWIX_ARCH="armhf" ; \
    fi ; \
    wget https://download.kiwix.org/release/kiwix-tools/kiwix-tools_linux-$KIWIX_ARCH.tar.gz && \
    tar -xf kiwix-tools_linux*.tar.gz --wildcards --strip-components=1 \
    'kiwix-tools*/kiwix-serve' && rm -f kiwix-tools_linux*

# Download NetHackWiki ZIM dump

RUN wget https://api.github.com/repos/tmp6154/nethackwiki-zim/releases/latest \
    -O - | grep 'browser_download_url.*zim' | cut -d '"' -f 4 | wget -i - -O ./nethackwiki.zim

# Expose server port

EXPOSE 8080

# Define launch command
CMD ["./kiwix-serve", "-p", "8080", "./nethackwiki.zim"]

