#!/bin/sh
# set variables
export PATH=${PATH}:${HOME}/.cabal/bin:${HOME}/go/bin:/usr/local/go/bin
# bind settings
if [ -z "${MONGOD_ALL_BIND}" ] && [ "${MONGOD_ALL_BIND:-A}" = "${MONGOD_ALL_BIND-A}" ]; then
        echo "Set mongodb bind 127.0.0.1"
else
        echo "Set mongodb bind 0.0.0.0"
        sed -i -e "s/bind_ip/#bind_ip/g" /etc/mongodb.conf
fi
# install packages
npm install --save-dev
bundle install
# build
npm run build
# start mongodb server
mongod &
# install pandocfilters
cd server/pandoc/pandocfilters && python ./setup.py install && cd /workspace
# start kokiake server
echo "KOKIAKE_ENV is ${KOKIAKE_ENV}"
npm run run:${KOKIAKE_ENV}
