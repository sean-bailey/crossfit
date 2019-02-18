#!/bin/sh
pip install -r ./requirements.txt -t ./dist
cp *.py ./dist
cd ./dist
zip -r ../lambda.zip .
