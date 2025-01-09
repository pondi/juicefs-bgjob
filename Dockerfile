FROM alpine:3.21.2@sha256:56fa17d2a7e7f168a043a2712e63aed1f8543aeafdcee47c58dcffe38ed51099 AS build

ARG JFS_VERSION_TAG

RUN apk add --no-cache curl fuse

RUN set -x && \
    mkdir /juicefs && \
    cd /juicefs && \
    curl -s -L "https://github.com/juicedata/juicefs/releases/download/v${JFS_VERSION_TAG}/juicefs-${JFS_VERSION_TAG}-linux-amd64.tar.gz" \
    | tar -zx && \
    install juicefs /usr/bin && \
    cd .. && \
    rm -rf /juicefs

FROM alpine:3.21.2@sha256:56fa17d2a7e7f168a043a2712e63aed1f8543aeafdcee47c58dcffe38ed51099

# Install necessary packages
RUN apk add --no-cache tzdata fuse

# Create a non-root user and group
RUN addgroup -S juicefs && adduser -S juicefs -G juicefs

# Copy juicefs binary and entrypoint script
COPY --from=build /usr/bin/juicefs /usr/bin/juicefs
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh

# Set permissions for the entrypoint script
RUN chmod +x /usr/local/bin/entrypoint.sh

# Change ownership of the juicefs binary to the juicefs user
RUN chown juicefs:juicefs /usr/bin/juicefs

# Allow the juicefs user to use FUSE
RUN echo 'user_allow_other' >> /etc/fuse.conf

# Create a mount point and set permissions
RUN mkdir -p /mnt/juicefs && chown juicefs:juicefs /mnt/juicefs

# Switch to the non-root user
USER juicefs

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
