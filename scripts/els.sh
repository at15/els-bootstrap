#!/usr/bin/env bash

${ELS_DOWNLOAD:=https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.2.0/elasticsearch-2.2.0.tar.gz}

cd ../bundle

echo "downloading elasticsearch from ${ELS_DOWNLOAD}"

# download if the tarball does not exists
if [ -f elasticsearch-2.2.0.tar.gz ]; then
    echo "tarball already exist"
else
    echo "start downloading from ${ELS_DOWNLOAD}"
    wget ${ELS_DOWNLOAD}
fi

# extract the tarball if not extracted
if [ -d "elasticsearch-2.2.0" ];then
  echo "elasticsearch already extracted"
else
  echo "extracting elasticsearch tarball"
  tar -zxvf ./elasticsearch-2.2.0.tar.gz -C .
fi

echo "elasticsearch setup finished"