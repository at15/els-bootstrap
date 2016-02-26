#!/usr/bin/env bash

# setup the ik analysis for elasticsearch
# https://github.com/medcl/elasticsearch-analysis-ik

cd ../bundle
# TODO:clone only one level is enough
git clone --depth=1 https://github.com/medcl/elasticsearch-analysis-ik
cd elasticsearch-analysis-ik
mvn clean
mvn compile
mvn package
# cd ..
# rm -rf elasticsearch-analysis-ik