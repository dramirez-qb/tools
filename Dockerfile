FROM frolvlad/alpine-glibc:latest

MAINTAINER Daniel Ramirez <dxas90@gmail.com>

ARG OC_VERSION=4.5
ARG DOCKER_VERSION=19.03.8
ARG KUBECTL_VERSION=v1.18.2
ARG KIND_VERSION=v0.8.1
ARG BUILD_DEPS='tar gzip'
ARG RUN_DEPS='curl ca-certificates gettext jq'

RUN apk --no-cache add $BUILD_DEPS $RUN_DEPS && \
    curl -sLo /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v$(echo $OC_VERSION | cut -d'.' -f 1)/clients/oc/$OC_VERSION/linux/oc.tar.gz && \
    curl -sLo /tmp/docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz && \
    curl -sLo /usr/local/bin/kind https://github.com/kubernetes-sigs/kind/releases/download/${KIND_VERSION}/kind-linux-amd64 && \
    curl -sSLo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    tar xzf /tmp/docker.tgz -C /tmp && \
    cp /tmp/docker/docker /usr/local/bin/ && \
    tar xzvf /tmp/oc.tar.gz -C /usr/local/bin/ && \
    chmod +x /usr/local/bin/* && \
    rm -rf /tmp/* && \
    apk del $BUILD_DEPS
