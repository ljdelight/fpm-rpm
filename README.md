
# fpm-rpm Docker image

[FPM](https://github.com/jordansissel/fpm) is used to create platform-native install packages such as deb and rpm. Since Debian hosts cannot create rpm packages, it makes sense to create an image that can run on Ubuntu and create deb or rpm packages.

The purpose of this image is create DEB or RPM packages using FPM on hosts which cannot otherwise create those packages.

# Creating a native installer
This image is most useful on Debian systems which need to build an RPM using fpm.

Here's an example setup before packaging:

    mkdir -p build/rpm/opt/ljdelight/example/
    echo "echo hello" > run.sh
    install --mode=0755 ./run.sh build/rpm/opt/ljdelight/example/

And package it into an rpm using the Docker image:

    docker run -v $(pwd):/data ljdelight/fpm-rpm \
        fpm -s dir -t rpm -C /data/build/rpm \
            --package /data/ \
            --version 1.0 --name testpackage --architecture amd64 \
            --maintainer "Lucas Burson" --vendor "Lucas Burson" --url http://ljdelight.com \
            --license BSL-1.0

Then the debian package:

    docker run -v $(pwd):/data ljdelight/fpm-rpm \
        fpm -s dir -t deb -C /data/build/rpm \
            --deb-no-default-config-files \
            --package /data/ \
            --version 1.0 --name testpackage --architecture amd64 \
            --maintainer "Lucas Burson" --vendor "Lucas Burson" --url http://ljdelight.com \
            --license BSL-1.0

We'll have two packages, testpackage-1.0-1.x86_64.rpm and testpackage_1.0_amd64.deb, ready for distribution.
