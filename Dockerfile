FROM fedora:37

RUN dnf -y update && dnf -y clean all
RUN dnf -y install btrfs-progs-devel \
  containers-common \
  device-mapper-devel \
  golang go-md2man \
  gpgme-devel \
  libassuan-devel \
  libseccomp-devel \
  make \
  net-tools \
  runc \
  shadow-utils \
  glibc-static \
  libselinux-static \
  libseccomp-static && \
  dnf -y clean all


ENV BUILDAH_ISOLATION chroot

COPY . /buildah

RUN cd /buildah && \
  make clean all install && \
  sudo make install && \
  buildah version && \
  rm -rf /buildah && \
  buildah version

WORKDIR /root
CMD /bin/bash
