#!/usr/bin/env bash

# setup the ik analysis for elasticsearch
# https://github.com/medcl/elasticsearch-analysis-ik

cd ../bundle

if [ -d "elasticsearch-analysis-ik" ];then
    echo "elasticsearch-analysis-ik already extracted"
else
    echo "clone elasticsearch-analysis-ik"
    git clone --depth=1 https://github.com/medcl/elasticsearch-analysis-ik
    cd elasticsearch-analysis-ik
    mvn clean
    mvn compile
    mvn package
fi

# find and extract the zip
# FIXME: the version for els and ik are all fixed 
# FIXME: zip is not found when first built, have to run the script twice
if [ -f "elasticsearch-analysis-ik/target/releases/elasticsearch-analysis-ik-1.8.0.zip" ]; then
   if [ ! -d "elasticsearch-2.2.0/plugins" ]; then
        mkdir elasticsearch-2.2.0/plugins
   fi
   if [ ! -d "elasticsearch-2.2.0/plugins/ik" ]; then
        echo "extracting plugin"
        unzip elasticsearch-analysis-ik/target/releases/elasticsearch-analysis-ik-1.8.0.zip -d elasticsearch-2.2.0/plugins/ik
   else
        echo "plugin already extracted"
   fi
else
    echo "built zip not found!"
fi