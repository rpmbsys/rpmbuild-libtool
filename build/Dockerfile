ARG centos=7.9.2009
ARG image=rpmb
FROM aursu/rpmbuild:${centos}-${image}

# install common build tools (autotools, compilers, parsers etc)
RUN yum -y --enablerepo bintray-custom install \
        autoconf \
        bison \
        flex \
        gcc-8.5.0 \
        gcc-c++-8.5.0 \
        libtool-2.4.6 \
        make \
        which \
    && yum clean all && rm -rf /var/cache/yum /var/lib/rpm/__db*

VOLUME ${BUILD_TOPDIR}/SRPMS ${BUILD_TOPDIR}/RPMS

USER $BUILD_USER
WORKDIR ${BUILD_TOPDIR}/SPECS
