#!/bin/bash
git submodule foreach -q --recursive 'echo "Processing $name" && git pull && echo ""'
