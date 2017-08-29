#!/bin/bash

# using a stack to implement "nested" remember-and-change functionality 
# use pushd and popd functions to enable you to move from one directory to another
# and have the shell remember the last directory you were in

pushd ()
{
    # first positional parameter provided to script
    dirname=$1

    # if cd into specified directory was successful
    if cd ${dirname:?"missing directory name"}
    then
        # DIR_STACK is initalized as an empty string in .bash_profile
        # expression within double quotes will be dirname followed by a space followed by PWD followed by a space
        # putting variable in double quotes ensures that the entire expression is stored as one string

        # if DIR_STACK has been set in previous iterations use that otherwise use PWD
        DIR_STACK="$dirname ${DIR_STACK:-$PWD' '}"
        echo $DIR_STACK

    # otherwise do nothing
    else
        echo "still in $PWD"
    fi
}

popd ()
{
    # if string is not null (has a length greater than 0)
    # put "$DIR_STACK" in double quotes so that when it is expanded it is treated as a single word
    # otherwise shell will expand it into multiple words and will complain too many args
    if [ -n "$DIR_STACK"]; then
        # #* will delete everything before the first space in the DIR_STACK string
        # this will delete the top directory from the stack
        # "/etc /home/you/lizard /home/you" will become "/home/you/lizard /home/you"
        DIR_STACK=${DIR_STACK#* }

        # %% * will delete everything after the first space 
        # "/home/you/lizard /home/you" will become "/home/you/lizard"
        # this is the directory we want to pass into the cd command because it is the most recent dir
        cd ${DIR_STACK%% *}

        # simply echo where you are in the file system
        echo "$PWD"
    else
        echo "stack empty, still in $PWD"
    fi
}
