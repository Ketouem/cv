FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/usr/local/bin:${PATH}"

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget \
        perl \
        ca-certificates \
        fontconfig \
        xz-utils \
    && rm -rf /var/lib/apt/lists/*

RUN wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh \
 && ln -sf /root/.TinyTeX/bin/*/* /usr/local/bin/ \
 && tlmgr install \
        latex \
        latex-bin \
        moderncv \
        raleway \
        fontaxes \
        fontawesome5 \
        ly1 \
        pgf \
        eso-pic \
        xcolor \
        etoolbox \
        l3packages \
        l3kernel \
        geometry \
        hyperref \
        graphics \
        graphics-def \
        url \
        microtype \
        ifmtarg \
        pdftexcmds \
        bookmark \
        rerunfilecheck \
        symbol \
        zapfding \
        ec \
        amsfonts

WORKDIR /data
