#!/bin/bash

# using a stack to implement "nested" remember-and-change functionality 
# use pushd and popd functions to enable you to move from one directory to another
# and have the shell remember the last directory you were in

pushd ()
{
    # first positional parameter provided to script
    dirname=$1

    # DIR_STACK is initalized as an empty string in .bash_profile
    # expression within double quotes will be dirname followed by a space followed by PWD followed by a space
    # putting variable in double quotes ensures that the entire expression is stored as one string
    DIR_STACK="$dirname ${DIR_STACK:-$PWD' '}"

    # cd into the specified directory if provided
    # otherwise print dirname followed by error message
    cd ${dirname:?"missing directory name"}

    # print the contents of the stack
    # leftmost directory is both the current directory and the top of the stack
    echo "$DIR_STACK"
}

popd ()
{
    # #* will delete everything before the first space in the DIR_STACK string
    # this will delete the top directory from the stack
    # "/etc /home/you/lizard /home/you" will become "/home/you/lizard /home/you"
    DIR_STACK=${DIR_STACK#* }

    # %% * will delete everything after the first space 
    # "/home/you/lizard /home/you" will become "/home/you/lizard"
    # this is the directory we want to pass into the cd command
    cd ${DIR_STACK%% *}

    # simply echo where you are in the file system
    echo "$PWD"
}
