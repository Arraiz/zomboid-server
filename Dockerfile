FROM ubuntu:20.04

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV USER=pzserver
ENV HOME=/home/${USER}
ENV STEAMCMD_PATH=${HOME}/steamcmd

# Install required dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    tar \
    bzip2 \
    gzip \
    unzip \
    python3 \
    binutils \
    bc \
    jq \
    tmux \
    ca-certificates \
    lib32gcc1 \
    lib32stdc++6 \
    libsdl2-2.0-0:i386 \
    default-jre \
    && rm -rf /var/lib/apt/lists/*

# Create user and set up directories
RUN useradd -m -s /bin/bash ${USER}
WORKDIR ${HOME}

# Switch to pzserver user
USER ${USER}

# Install LinuxGSM
RUN curl -Lo linuxgsm.sh https://linuxgsm.sh && \
    chmod +x linuxgsm.sh && \
    bash linuxgsm.sh pzserver

# Copy entrypoint script
COPY --chown=${USER}:${USER} entrypoint.sh ${HOME}/entrypoint.sh
RUN chmod +x ${HOME}/entrypoint.sh

VOLUME ["${HOME}/Zomboid", "${HOME}/.steam", "${HOME}/Steam"]

EXPOSE 16261/udp 16262/udp

ENTRYPOINT ["./entrypoint.sh"] 