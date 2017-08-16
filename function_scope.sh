#!/bin/bash

function afunc
{
    # keeps value of var1 local to function
    local var1
    echo in function: $0 $1 $2

    var1="in function"
    echo var1: $var1
}

var1="outside function"
echo var1: $var1
echo $0: $1 $2

afunc funcarg1 funcarg2
# specifying local within the function on line 6 will keep var1 on line 19 as "outside function" 
echo var1: $var1
echo $0: $1 $2
