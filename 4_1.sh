#!/bin/bash

# ./4_1.sh filename [n value for head -n]

filename=$1
# if filename was not specified print varname followed by message
filename=${filename:?"missing"}
# optional argument to specify number to list
n=$2

# -n option tells sort to interpret the first word on each line as a number
# -r tells sort to reverse the default order so descending with highest numbers on top and lowest on bottom
# if a second argument was passed in then this will be the n
# otherwise ${varname:=default} allows us to return a default value of 5 if the second argument was not provided
sort -nr $filename | head -${n:=5}
