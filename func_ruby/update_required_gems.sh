#!/usr/bin/bash

if [ -e /opt/brepo/ruby33/bin/bundle ]; then
    /opt/brepo/ruby33/bin/bundle install
else
    bundle install
fi
