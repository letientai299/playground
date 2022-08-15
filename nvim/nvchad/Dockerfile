FROM alpine:edge
WORKDIR /work

RUN apk add git nodejs neovim ripgrep alpine-sdk --update \
  && rm -rf /var/cache/apk/* \
  && git clone --depth=1 https://github.com/NvChad/NvChad /root/.config/nvim

ENTRYPOINT ["nvim"]
