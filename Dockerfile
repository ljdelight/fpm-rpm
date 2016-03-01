FROM centos:latest
MAINTAINER Lucas Burson <ljdelight@gmail.com>

RUN yum install -y \
        build-essential \
        gcc \
        libffi-devel \
        make \
        redhat-rpm-config \
        rpm-build \
        ruby-devel \
    && gem install fpm

CMD ["fpm"]
