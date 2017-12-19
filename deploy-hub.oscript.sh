#!/bin/bash
set -e

temp=`cat packagedef | grep ".Версия(" | sed 's|[^"]*"||' | sed -r 's/".+//'`;
export VERSION=${temp##*|}; 
oscript /usr/share/oscript/lib/opm/src/opm.os push --token $GITHUB_OAUTH_TOKEN --channel stable --file ./cli-$VERSION.ospx;
