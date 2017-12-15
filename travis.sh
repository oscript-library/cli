#!/bin/bash
set -e

oscript /usr/share/oscript/lib/opm/src/opm.os test

temp=`cat packagedef | grep ".Версия(" | sed 's|[^"]*"||' | sed -r 's/".+//'`
version=${temp##*|}
