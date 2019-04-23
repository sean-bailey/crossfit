#!/bin/sh
if [ -f "./lambda.zip" ] ; then
    rm "./lambda.zip"
fi
if [ -f "~/.pydistutils.cfg" ] ; then
    rm "~/.pydistutils.cfg"
fi
mkdir -p ./dist
echo "[install]
prefix=" > ~/.pydistutils.cfg
cd ./dist
pip install -r ../requirements.txt --target .
zip -r9 ../lambda.zip .
cd ..
zip -g ./lambda.zip ./*.py
rm -rf ./dist
if [ -f "~/.pydistutils.cfg" ] ; then
    rm "~/.pydistutils.cfg"
fi
