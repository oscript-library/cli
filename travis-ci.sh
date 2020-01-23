set -e
echo "Устанавливаю версию OScript <$OSCRIPT_VERSION>"
curl -L http://oscript.io/downloads/$OSCRIPT_VERSION/deb&bitness=x64 > oscript.deb 
dpkg -i oscript.deb 
rm -f oscript.deb

opm install 1testrunner; 
opm install 1bdd; 
opm install coverage; 

opm install; 

opm run coverage;


# oscript ./tasks/coverage.os
