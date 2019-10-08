# nethackwiki-local-docker

## Run a local mirror of NetHackWiki in Docker

If you want to play NetHack while having no internet access, but still want to have access to the spoilers - here's the solution! This Docker image packages together the [offline ZIM dump of NetHackWiki](https://github.com/tmp6154/nethackwiki-zim) and *kiwix-serve* from the [kiwix-tools](https://github.com/kiwix/kiwix-tools) suite to serve a local mirror of NetHackWiki on the localhost, or even in LAN.

This image can be built and works both on x86-64 and ARM hosts (and so can be used on e.g. Raspberry Pi) and should work in any browser (including text-based browsers, such as Links2).

## Running the image from the Docker Hub

Just run this command *(x86-64 only)*.

    docker run --rm -d -p 8080:8080 --name nethackwiki tmp6154/nethackwiki-local-docker

This will start a container with kiwix-serve listening on port 8080. You just have to open **http://localhost:8080** in your browser and you can browse NetHackWiki ZIM dump.

## Building and running the image from Dockerfile

If you're running on ARM (or just want to build image yourself) - you would have to clone this repository, *cd* to it and run the following command:

    docker build -t nethackwiki .

Note that you should have internet access at the time of build.

After this command finishes, you should have a local image "nethackwiki", from which you could then run an offline instance of NetHackWiki like this:

    docker run --rm -d -p 8080:8080 --name nethackwiki nethackwiki

## License

![GPLv3](https://github.com/tmp6154/nethackwiki-local-docker/blob/master/img/gplv3.png?raw=true "GPLv3")
