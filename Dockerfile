FROM quay.io/buildah/stable:v1.26.0

COPY . /buildah

RUN yum -y update; rpm --restore shadow-utils 2>/dev/null; yum -y install \
     make \
     cpp \
     golang \
     bats \
     btrfs-progs-devel \
     device-mapper-devel \
     glib2-devel \
     gpgme-devel \
     libassuan-devel \
     libseccomp-devel \
     git \
     bzip2 \
     xz \
     go-md2man \
     runc \
     fuse-overlayfs \
     fuse3 \
     containers-common;

RUN cd /buildah && \
  sudo make uninstall && \
  make clean all install && \
  sudo make install && \
  buildah version && \
  rm -rf /buildah && \
  yum -y remove bats git golang go-md2man make && \
  yum clean all && \
  buildah version

WORKDIR /root
CMD /bin/bash
