#!/usr/bin/env bash

set -e
set -o pipefail

source ./scripts/osx/setup.sh

BUILDTYPE=${BUILDTYPE:-Release}

################################################################################
# Build
################################################################################

mapbox_time "checkout_styles" \
git submodule update --init styles

mapbox_time "checkout_geojsonvt" \
git submodule update --init src/mbgl/util/geojsonvt

mapbox_time "compile_program" \
make xosx -j${JOBS} BUILDTYPE=${BUILDTYPE}

mapbox_time "compile_render_binary" \
make xrender -j${JOBS} BUILDTYPE=${BUILDTYPE}

mapbox_time "compile_tests" \
make xtest -j${JOBS} BUILDTYPE=${BUILDTYPE}
