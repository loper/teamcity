#!/bin/bash

echo "(*) just a test"

echo "hostname: $(hostname)"

echo "dirs:"
pwd
ls

uname -a > artifact.log

date
