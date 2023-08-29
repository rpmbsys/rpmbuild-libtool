ARG os=7.9.2009
FROM aursu/rpmbuild:${os}-build

ARG repopath=rpmb.jfrog.io/artifactory/custom
ENV YUM0 $repopath

USER root
RUN yum -y install \
        help2man \
        texinfo \
    && yum clean all && rm -rf /var/cache/yum

RUN rpm -e libtool \
    && yum -y --enablerepo bintray-custom install \
        gcc-c++-8.5.0 \
        gcc-gfortran-8.5.0 \
        libstdc++-devel-8.5.0 \
    && yum clean all && rm -rf /var/cache/yum

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "libtool.spec"]
CMD ["-ba"]
