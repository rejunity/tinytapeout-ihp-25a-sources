#!/bin/bash
f4pga -vv build --flow checkers.json
mkdir -p build/log
mv *.log build/log/
