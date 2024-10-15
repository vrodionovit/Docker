# Используем Ubuntu как базовый образ
FROM debian:10

# Устанавливаем переменную окружения для неинтерактивной установки пакетов
ENV DEBIAN_FRONTEND=noninteractive

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    unzip wget git make bison flex libntlm0-dev libtool libgtk-3-dev g++ \
    libssl-dev zlib1g-dev libasound2-dev libgudev-1.0-dev libpulse-dev cmake \
    libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
    libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa \
    gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio \
    alsa-base alsa-utils pulseaudio \
    autoconf automake libtool pkg-config

# Клонируем репозиторий
RUN git clone https://github.com/Quedale/OnvifDeviceManager.git

WORKDIR /OnvifDeviceManager

# Запускаем autogen.sh
RUN ./autogen.sh --prefix=/usr


# Создаем deb-пакет
RUN make deb

# Копируем созданный deb-пакет в корневую директорию
RUN cp *.deb /

# Команда по умолчанию для отображения созданного deb-пакета
CMD ls -l /*.deb
