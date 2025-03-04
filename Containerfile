ARG BAZZITE_TAG
FROM ghcr.io/ublue-os/bazzite-deck:${BAZZITE_TAG}

## Other possible base images include:
# FROM ghcr.io/ublue-os/bazzite:stable
# FROM ghcr.io/ublue-os/bluefin-nvidia:stable
# 
# ... and so on, here are more base images
# Universal Blue Images: https://github.com/orgs/ublue-os/packages
# Fedora base image: quay.io/fedora/fedora-bootc:41
# CentOS base images: quay.io/centos-bootc/centos-bootc:stream10

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

ARG AKMODSEXTRA_TAG
COPY --from=ghcr.io/ublue-os/akmods-extra:${AKMODSEXTRA_TAG} /rpms/ /tmp/rpms
RUN find /tmp/rpms

# add the ublue copr
RUN curl -L https://copr.fedorainfracloud.org/coprs/ublue-os/akmods/repo/fedora-41/ublue-os-akmods-fedora-41.repo \
         -o /etc/yum.repos.d/ublue-os-akmods-fedora-41.repo

RUN rpm-ostree install /tmp/rpms/kmods/*nct6687*.rpm