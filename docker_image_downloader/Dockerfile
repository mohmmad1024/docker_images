FROM golang
USER root

RUN apt-get update && apt-get install -y wget curl jq && mkdir -p /images && mkdir -p /web \
	&& cd /web && wget https://raw.githubusercontent.com/moby/moby/master/contrib/download-frozen-image-v2.sh && chmod +x download-frozen-image-v2.sh
RUN ln -s /web/download-frozen-image-v2.sh /usr/bin/did && echo 'echo the tar is ready on $dir.tar'>> /web/download-frozen-image-v2.sh && echo 'tar -cC $dir -f $dir.tar .'>> /web/download-frozen-image-v2.sh
WORKDIR /images

ADD . /web
CMD go run /web/web.go & echo USE did commadn && bash
