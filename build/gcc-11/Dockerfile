ARG os=7.9.2009
ARG image=rpmb
FROM aursu/rpmbuild:${os}-${image}

ARG repopath=rpmb.jfrog.io/artifactory/custom
ARG gccrepopath=rpmb.jfrog.io/artifactory/gcc11custom
ARG repoproxy=

ENV YUM0 $repopath
ENV YUM2 $gccrepopath
ENV YUM3 centos

ENV http_proxy $repoproxy
ENV https_proxy $repoproxy

USER root
COPY system/etc/yum.repos.d/bintray-gcccustom-yum.repo /etc/yum.repos.d/bintray-gcccustom.repo

# install common build tools (autotools, compilers, parsers etc)
RUN yum -y --enablerepo bintray-custom --enablerepo bintray-gcccustom install \
        autoconf \
        bison \
        flex \
        gcc-11.3.1 \
        gcc-c++-11.3.1 \
        "libtool >= 2.4.6" \
        make \
        which \
    && yum clean all && rm -rf /var/cache/yum /var/lib/rpm/__db*

VOLUME ${BUILD_TOPDIR}/SRPMS ${BUILD_TOPDIR}/RPMS

USER $BUILD_USER
WORKDIR ${BUILD_TOPDIR}/SPECS
