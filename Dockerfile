FROM docker:23-cli

ARG ARCH=arm64
ENV ARCH=${ARCH}
ENV PATH="/usr/local/bin:${PATH}"

# 1) Paketler
RUN apk add --no-cache \
    iptables \
    git \
    curl \
    bash \
    ca-certificates \
    conntrack-tools

# 2) kubectl
RUN curl -Lo /usr/local/bin/kubectl \
    https://dl.k8s.io/release/v1.25.9/bin/linux/${ARCH}/kubectl \
 && chmod +x /usr/local/bin/kubectl

# 3) kustomize
RUN curl -Lo /tmp/kustomize.tar.gz \
      https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v4.5.4/kustomize_v4.5.4_linux_${ARCH}.tar.gz \
 && tar -xzf /tmp/kustomize.tar.gz -C /usr/local/bin kustomize \
 && chmod +x /usr/local/bin/kustomize \
 && rm /tmp/kustomize.tar.gz

# 4) minikube
RUN curl -Lo /usr/local/bin/minikube \
      https://storage.googleapis.com/minikube/releases/v1.31.2/minikube-linux-${ARCH} \
 && chmod +x /usr/local/bin/minikube

# 5) entrypoint 
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
