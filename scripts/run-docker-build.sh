#!/bin/bash

# This script is meant to be run on the host machine

PROJECT_ROOT=$(git rev-parse --show-toplevel)

echo "Building Docker image.." && \
docker build -t flaccid/arch-makepkg:latest . && \
echo "Running Docker build.."
docker run -ti --rm --name aarch64-kernel-packager -v $(pwd)/scripts:/scripts -v $(pwd)/package:/package flaccid/arch-makepkg:latest /scripts/build-package.sh && \
echo "Build competed successfully!" && \
echo "The following packages were created:" && \
find ${PROJECT_ROOT}/package -name "*.pkg.tar.zst"
