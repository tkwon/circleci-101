# create python image with ffmpeg for use in songback

FROM circleci/python:3.6.8

RUN sudo apt-get update && \
sudo apt-get install libspeex-dev yasm libtheora-dev \
build-essential libmp3lame-dev libvorbis-dev \
pkg-config libx264-dev libopenjp2-7-dev libvorbis-dev libx264-dev

RUN mkdir /tmp/deps && cd /tmp/deps && wget https://netcologne.dl.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz && \
tar -zxvf lame-3.99.5.tar.gz && cd lame-3.99.5 && ./configure && make && sudo make install

RUN mkdir /tmp/ffmpeg && cd /tmp/ffmpeg/ && \
wget http://ffmpeg.org/releases/ffmpeg-4.0.1.tar.gz && tar -zxvf ffmpeg-4.0.1.tar.gz && cd ffmpeg-4.0.1

RUN sudo /tmp/ffmpeg/ffmpeg-4.0.1/configure --enable-gpl --enable-postproc \
--enable-swscale --enable-avfilter --enable-libmp3lame --enable-libvorbis \
--enable-libtheora --enable-libx264 --enable-libspeex --enable-shared \
--enable-pthreads --enable-nonfree --enable-libopenjpeg && \
sudo make && \
sudo make install

RUN sudo /sbin/ldconfig

