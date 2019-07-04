#!/bin/bash

set +x # debug output: false
set -e # exit on error: true

# Remember current directory and jump to directory of this bash file
# Assume that this bash file is located in 'chess-documentation'
BASH_FILE_DIR=$(dirname $0)
pushd $(pwd)
pushd $BASH_FILE_DIR

# Build chess-app.js
pushd ../chess-react
	npm install
	npm run build
popd

# Generate the tutorial page
pushd doc
	asciidoctor -a stylesheet=n4js-adoc.css n4js-tutorial-chess.adoc
	asciidoctor -a stylesheet=n4js-adoc.css n4js-tutorial-chess-redux.adoc
popd

# Move all generated files into doc/n4js-tutorial-chess folder
OUTPUTDIR=generated-html
mkdir -p $OUTPUTDIR
mkdir -p $OUTPUTDIR/dist
mkdir -p $OUTPUTDIR/images

cp -r doc/images/*.png doc/images/*.svg $OUTPUTDIR/images/
cp ../chess-react/index.html $OUTPUTDIR/chess.html
mv ../chess-react/dist/chess-app.js $OUTPUTDIR/dist/chess-app.js
mv doc/n4js-tutorial-chess.html $OUTPUTDIR/
mv doc/n4js-tutorial-chess-redux.html $OUTPUTDIR/

popd
popd
