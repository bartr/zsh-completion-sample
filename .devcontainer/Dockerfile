# this image is built and updated weekly
# https://github.com/cse-labs/codespaces-images

FROM ghcr.io/cse-labs/dind:latest

# some images require specific values
ARG USERNAME=vscode

# make sure zsh completion is enabled
RUN echo "" >> /home/vscode/.zshrc && \
    echo "unsetopt complete_aliases" >> /home/vscode/.zshrc && \
    echo "autoload -U compinit" >> /home/vscode/.zshrc && \
    echo "zstyle ':completion:*:descriptions' format '%d'" >> /home/vscode/.zshrc
