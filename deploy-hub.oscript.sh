#!/bin/bash
set -e
export CHANNEL=dev
if [ $TRAVIS_BRANCH == "master" ]; then export CHANNEL=stable;fi
temp=`cat packagedef | grep ".Версия(" | sed 's|[^"]*"||' | sed -r 's/".+//'`;
export VERSION=${temp##*|}; 
oscript /usr/share/oscript/lib/opm/src/opm.os push --token $GITHUB_OAUTH_TOKEN --channel $CHANNEL --file ./cli-$VERSION.ospx;
