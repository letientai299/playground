FROM golang:latest
WORKDIR /work

RUN apt-get update -yqq && \
  apt-get install -yqq \
  git unzip wget curl ripgrep fd-find \
  ninja-build gettext libtool-bin cmake g++ pkg-config

RUN git clone --depth=1 https://github.com/NvChad/NvChad /root/.config/nvim

RUN git clone --depth=1 https://github.com/neovim/neovim /root/.src/nvim && \
  cd /root/.src/nvim && make install

ENTRYPOINT ["nvim"]
