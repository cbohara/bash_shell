#!/bin/bash

if [ -z "$1" ]; then
    # add standard UNIX usage message to clarify you need a filename
    # [ ] typically used to denote optional argument
    echo 'usage: highest filename [-N]'
    exit 1
fi

filename=$1
howmany=${2:-10}
sort -nr $filename | head -$howmany
