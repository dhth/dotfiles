#!/usr/bin/env bash

set -e

echo "updating cursor_smear_fade.glsl"
curl -sSLO https://raw.githubusercontent.com/KroneCorylus/ghostty-shader-playground/refs/heads/main/public/shaders/cursor_smear_fade.glsl

echo "updating cursor_blaze.glsl"
curl -sSLO https://raw.githubusercontent.com/hackr-sh/ghostty-shaders/refs/heads/main/cursor_blaze.glsl
