#!/bin/bash -e

echo edit-me-first please
exit 1

if [ !  -f Guardfile ] ; then
    echo this script must be run from the machinekit-doc directory
    exit 1
fi

if [ !  -f _host.yml ] ; then
    echo you need to create a _host.yml file containing the IP address
    echo of the serving box like so:
    echo "host: <IP address>\nurl: http://<IP address>\n"
    exit 1
fi

# fetch the latestg docker image (4GB):
# once done, takes a few seconds, but will get you any updates
# automatically
docker pull haberlerm/docker-jekyll-asciidoctor


docker run --user $(id -u):$(id -g) \
  -p 4000:4000 -p 35729:35729 \
  -it -v $(pwd):/work haberlerm/docker-jekyll-asciidoctor \
   jekyll serve --host=0.0.0.0  --verbose   --trace --watch \
  --config _config.yml,_host.yml --skip-initial-build
