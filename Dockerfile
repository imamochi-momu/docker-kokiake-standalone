FROM ubuntu:16.04
MAINTAINER imamochi_momu "momu@ll-x-ll.me"
ENV DEBIAN_FRONTEND noninteractive
# install package
RUN apt-get update \
&& apt-get dist-upgrade -y \
&& apt-get install -y texlive-full haskell-platform golang git build-essential mongodb wget vim ruby ruby-dev \
&& apt-get clean
# install pandoc
RUN cabal update \
&& cabal install zip-archive \
&& cabal install pandoc pandoc-citeproc
# install javascript development package
RUN apt-get install -y nodejs npm \
&& npm cache clean \
&& npm install n -g \
&& n stable \
&& ln -sf /usr/local/bin/node /usr/bin/node \
&& apt-get purge -y nodejs npm \
&& apt-get clean
# install golang development package
RUN mkdir -p /root/go
ENV GOPATH /root/go
RUN go get gopkg.in/mgo.v2 \
github.com/spf13/viper \
github.com/gin-gonic/gin \
github.com/davecgh/go-spew/spew \
golang.org/x/oauth2 \
github.com/golang/glog \
github.com/gin-gonic/contrib/sessions \
github.com/gorilla/websocket \
github.com/gin-gonic/contrib/renders/multitemplate \
cloud.google.com/go/compute/metadata
# install ruby development package
RUN gem install bundler sass --no-ri --no-doc
# set working directory
WORKDIR /workspace/
# add startup script
ADD scripts/docker-init.sh /bin/docker-init.sh
# set startup script
CMD ["/bin/docker-init.sh"]
