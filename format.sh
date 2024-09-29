#!/usr/bin/env bash

set -e

shfmt -i 4 -w $(git ls-files '**.sh')
shfmt -i 4 -w utils/exe/**
