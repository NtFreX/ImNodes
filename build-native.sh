#!/usr/bin/env bash

scriptPath="`dirname \"$0\"`"
cimnodesPath=$scriptPath/cimnodes

_CMakeBuildType=Debug
_CMakeOsxArchitectures=

while :; do
    if [ $# -le 0 ]; then
        break
    fi

    lowerI="$(echo $1 | awk '{print tolower($0)}')"
    case $lowerI in
        debug|-debug)
            _CMakeBuildType=Debug
            ;;
        release|-release)
            _CMakeBuildType=Release
            ;;
        -osx-architectures)
            _CMakeOsxArchitectures=$2
            shift
            ;;
        *)
            __UnprocessedBuildArgs="$__UnprocessedBuildArgs $1"
    esac

    shift
done

cp -r ./CMakeLists.txt $cimnodesPath
mkdir -p $cimnodesPath/build/$_CMakeBuildType
pushd $cimnodesPath/build/$_CMakeBuildType
cmake ../.. -DCMAKE_OSX_ARCHITECTURES="$_CMakeOsxArchitectures" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.13 -DCMAKE_BUILD_TYPE=$_CMakeBuildType
make
popd

rm $cimnodesPath/CMakeLists.txt
