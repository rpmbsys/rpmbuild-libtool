ARG os=7.9.2009
FROM aursu/rpmbuild:${os}-build

ARG repopath=rpmb.jfrog.io/artifactory/custom
ARG gccrepopath=rpmb.jfrog.io/artifactory/custom
ARG repoproxy=

ENV YUM0 $repopath
ENV YUM2 $gccrepopath
ENV YUM3 centos

ENV http_proxy $repoproxy
ENV https_proxy $repoproxy

USER root
COPY system/etc/yum.repos.d/bintray-gcccustom-yum.repo /etc/yum.repos.d/bintray-gcccustom.repo

RUN yum -y install \
        help2man \
        texinfo \
    && yum clean all && rm -rf /var/cache/yum /var/lib/rpm/__db*

RUN rpm -e libtool \
    && yum -y --enablerepo bintray-custom install \
        gcc-c++-8.5.0 \
        gcc-gfortran-8.5.0 \
        libstdc++-devel-8.5.0 \
    && yum clean all && rm -rf /var/cache/yum /var/lib/rpm/__db*

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "libtool.spec"]
CMD ["-ba"]
