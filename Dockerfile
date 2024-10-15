#FROM debian:10
FROM dockerhub1.beget.com/library/debian:10


# Обновляем списки пакетов и устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    git \
    pkg-config \
    libgtk-3-dev \
    make \
    g++ \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    bison \
    flex \
    libtool \
    wget
    libssl-dev \
    zlib1g-dev \
    libasound2-dev \
    libgudev-1.0-dev \
    libx11-xcb-dev \
    gettext \
    libpulse-dev \
    nasm \
    libntlm0-dev \
    && rm -rf /var/lib/apt/lists/*

# Обновляем pip и устанавливаем дополнительные инструменты
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir meson ninja cmake

WORKDIR /build

# Клонируем репозиторий
RUN git clone https://github.com/Quedale/OnvifDeviceManager.git

WORKDIR /build/OnvifDeviceManager

# Запускаем скрипт autogen.sh
RUN ./autogen.sh --prefix=$(pwd)/dist --enable-latest

# Команда по умолчанию для сборки deb пакета
CMD ["make", "deb"]
