#!/bin/bash

if [[ $1 = "init" ]]; then
    npm install selenium-standalone --save-dev \
        && npm install webdriverio --save-dev \
        && npm install wdio-mocha-framework --save-dev \
        && npm install chai --save-dev \
        && node_modules/webdriverio/bin/wdio config
elif [[ $1 = "install" ]]; then
    npm install
elif [[ $1 = "update" ]]; then
    npm update
elif [[ $1 = "wdio" ]]; then
    npm install
    node_modules/selenium-standalone/bin/selenium-standalone install
    node_modules/selenium-standalone/bin/selenium-standalone start > /dev/null 2>&1 \
        & sleep 1 && node_modules/webdriverio/bin/wdio wdio.conf.js
else
  eval $1
fi
