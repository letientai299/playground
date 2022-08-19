FROM alpine:edge
WORKDIR /work

RUN apk update
RUN apk add git nodejs neovim fd ripgrep npm alpine-sdk rustup unzip curl wget
RUN rustup-init --default-toolchain nightly -y
RUN git clone --depth=1 https://github.com/NvChad/NvChad /root/.config/nvim

ENTRYPOINT ["nvim"]
