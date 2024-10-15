FROM mirror.gcr.io/library/debian:10

ENV DEBIAN_FRONTEND=noninteractive

# Обновляем списки пакетов и устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    git \
    pkg-config \
    libgtk-3-dev \
    make \
    g++ \
    python3-pip \
    bison \
    flex \
    libtool \
    libssl-dev \
    zlib1g-dev \
    libasound2-dev \
    libgudev-1.0-dev \
    libx11-xcb-dev \
    gettext \
    libpulse-dev \
    nasm \
    wget \ 
    libntlm0-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

# Клонируем репозиторий
RUN git clone https://github.com/Quedale/OnvifDeviceManager.git

WORKDIR /build/OnvifDeviceManager

# Запускаем скрипт autogen.sh
RUN ./autogen.sh --prefix=$(pwd)/dist --enable-latest

# Команда по умолчанию для сборки deb пакета
CMD ["make", "deb"]
