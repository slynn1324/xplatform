#!/bin/sh



if [ ! -d "build" ]; then
  mkdir "build"
fi

if [ ! -d "build/emsdk_portable" ]; then
	tar xvzf emsdk-portable.tar.gz -C build

	# Fetch the latest registry of available tools.
	build/emsdk_portable/emsdk update

	# Download and install the latest SDK tools.
	build/emsdk_portable/emsdk install latest

	# Make the "latest" SDK "active"
	build/emsdk_portable/emsdk activate latest
fi

#
# Compile the things
#


# compile c binary
echo "Compiling C Binary"
gcc functions.c -o build/functions
echo "Compiled C Binary"
echo ""

# compile JavaScript via Emscripten
echo "Compiling JavaScript via Emscripten"
python build/emsdk_portable/emscripten/1.35.0/emcc functions.c -s EXPORTED_FUNCTIONS="['_add','_getMessage']" -o build/functions.js
cp functions.html build/functions.html
echo "Compiled JavaScript via Emscripten"
echo ""

# compile JavaScript Node via Emscripten
echo "Compiling Node JavaScript via Emscripten"
python build/emsdk_portable/emscripten/1.35.0/emcc functions.c -o build/functions_node.js
echo "Compiled Node JavaScript via Emscripten"
echo ""


# compile Java
echo "Compiling Java JNA"
javac -cp jna.jar -d build FunctionsJNA.java
cp jna.jar build/jna.jar
# compile dynamiclib
echo "Compiling Shared library for JNA"
gcc -dynamiclib -o build/libfunctions.dylib functions.c
echo "Compiled Java JNA"
echo ""


# compile Java JS
echo "Compile Java JS"
javac -d build FunctionsJS.java
echo "Compiled Java JS"
echo ""

# copy Groovy JS
echo "Copy Groovy JS"
cp FunctionsJS.groovy build/FunctionsJS.groovy
echo "Copied Groovy JS"
echo ""


echo ""
echo ""
echo "Now let's test it..."
echo ""
echo ""


#
# Test the things
# 

cd build

# c
echo "Testing C Binary:"
./functions


# java
echo ""
echo "Testing Java JNA:"
java -cp '.:jna.jar' FunctionsJNA

# java js
echo ""
echo "Testing Java JS:"
java FunctionsJS

# groovy js
echo ""
echo "Testing FunctionsJS groovy:"
groovy FunctionsJS.groovy

# javascript node
echo ""
echo "Testing JavaScript via Node:"
build/emsdk_portable/node/4.1.1_64bit/bin/node functions_node.js


# javascript web
echo ""
echo "Testing JavaScript via browser:"
open functions.html
echo "Opened build/functions.html in Browser"

echo ""







