FROM ubuntu:22.04

# Build arguments
ARG NHS_VERSION=3.1.36
ARG DEBIAN_FRONTEND=noninteractive

# Labels for container metadata
LABEL maintainer="dlfraga"
LABEL version="${NHS_VERSION}"
LABEL description="NHS UPS Server container for energy monitoring and UPS control"

# Install dependencies and NHS Server in one layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        unzip \
        tzdata \
        curl \
        ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy and install NHS Server
COPY ./nhsups_${NHS_VERSION}_x86_64_eGLIBC_2.11.zip /tmp/
RUN cd /tmp && \
    unzip ./nhsups_${NHS_VERSION}_x86_64_eGLIBC_2.11.zip && \
    cd nhsups_${NHS_VERSION}_x86_64_eGLIBC_2.11/ && \
    chmod +x install.sh && \
    ./install.sh && \
    chmod +x /usr/local/nhs/nhsupsserver && \
    rm -rf /tmp/nhsups_${NHS_VERSION}_x86_64_eGLIBC_2.11/ /tmp/nhsups_${NHS_VERSION}_x86_64_eGLIBC_2.11.zip

# Create volume for persistent configuration
VOLUME ["/usr/local/nhs/conf"]

# Expose NHS Server port
EXPOSE 2001

# Set working directory
WORKDIR /usr/local/nhs/

# Health check to verify server is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:2001 || exit 1

# Run NHS Server
CMD ["/usr/local/nhs/nhsupsserver"]
