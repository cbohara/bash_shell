Notes from Learning the Bash Shell by Cameron Newham and Bill Rosenblatt

#####
intro
#####

shell = user interface with the OS
any program that takes input from the user > translates instructions to OS > convey OS output back to user

before personal computers each user would connect with the larger the computer via a terminal device
the terminal device would be connected to the main computer via a cable
it was not a computer - it was only a keyboard and a display

terminal emulator allows us to access the Unix command line on our personal computers 
the shell is the program running in the terminal emulator and communicates directly with the OS
terminal window contains shell prompt

command [-option] argument

command = action
arguments/parameters = things command will act on
option = special type of argument that gives command specific info on what it is supposed to do 

files
    regular files
        text files
        contain readable characters
    executable files
        aka programs
        invoked as commands 
        some cannot be read by humans
        others are scripts which are just special text files

directories
    top of the tree directory = system directory = root (/)
    all files can be named by expressing their location relative to root
    $ cd /

    use relative pathnames when the location of the file is relative to the current working directory

    when you log into the system the working dir is set to home/login dir for the user (~)
    $ cd ~ 

    . and .. are special hidden files in each directory 
    . points to the directory itself
    .. points to the parent directory
    $ cd ..
    
    cd to whatever directory you were in before the current directory
    $ cd -

wildcards with pathname expansion
    ? any single char

    * any string of chars

        ex: bob, darlene, dave, ed, frank, and fred are files in cwd
        expression  yields                  demonstrates
        *ed         ed fred                 * can stand for nothing
        *r*         darlene frank fred      can use more than one *
        g*          g*                      no match = leaves expression untouched

    [set] any char in the set

    [!set] any char not in the set

        expression      matches
        [abc]           a, b, or c
        [.,;]           period, comma, or semi-colon
        [a-z]           all lowercase letters
        [a-zA-Z]        all lower and uppercase letters
        [!0-9]          all non digits
        [a-zA-Z0-9]     all alpha numeric chars

    pathname expansion
        expand to files and directories that exist

        ex: list all files in /usr/ and /usr2/
        $ ls /usr*

        commands only see results of the wildcard expansion
        wildcard expansion happens first and then the arguments are passed to the command
        $ ls /usr/ /usr2/

        putting '*.c' in quotes allows the find command itself to match the string against the names of files
        avoids the wildcard expansion from happening first
        $ find . -name '*.c'

brace expansion
    generates string based on pattern

    $ echo b{ed,olt,ar}s
    beds bolts bars

    $ echo {2..5}
    2 3 4 5

    $ echo {d..h}
    d e f g h

    can use with wildcard expansion
    $ ls hadoop_with_python/pig/*.{pig,py}

standard I/O
    each Unix program has a single way of
        accepting input = standard input
        producing output = standard output
        producing error messages = standard error

    each program you invoke has 3 standard I/O channels set to your terminal

    command < filename
        if command does not take filename arguments
        command takes stdin from file instead of from terminal

    command > filename
        command's stdout will be directed to a file

    pipelines redirect the stdout of 1 command to stdin of another command

background jobs
    whenever you enter a command you are telling the shell to run that command in a subprocess

    foreground job
        when you enter a command into the terminal
        the shell will let the command have control of the terminal until its done

    background job
        to do other things while the command is running
        put an & after the command
        get shell prompt back immediately

    $ jobs
        shows the jobs running from the terminal
        with status

    $ diff warandpeace.txt warandpeace.txt.old > txtdiff &
        instead of printing stdout to screen 
        save to txtdiff file

continuing lines - use ' ' or \

    $ echo 'The Caterpillar and Alice looked at each other for some
    > time in silence: at last Caterpillar took the hookah out of its 
    > mouth, and addressed her in a languid, sleepy voice.'

    $ echo The Caterpillar and Alice looked at each other for some \
    > time in silence: at last Caterpillar took the hookah out of its \
    > mouth, and addressed her in a languid, sleepy voice.

control keys
    $ stty all
    $ stty -a



####################
command line editing 
####################

“Why can’t I edit my UNIX command lines in the same way I can edit text with an editor?”
you can with bash!

set -o turns on the option
set +o turns off the option
$ set -o vi

history list
    whenever you log in or start another interactive shell
    bash reads the initial history list from ~/.bash_history

    from that point on each bash session maintains its own list of commands
    when you exit the shell it saves history to ~/.bash_history

vi editing modes
    input mode
        typing commands
        normal bash use
    control mode
        move around and edit in the command line using vi commands
            B 
                back to the beginning of an entire word even if it contains special chars (ex: beginning of URL)
            fx
                move right to the next occurance of x
            Fx
                move left to the previous occurance of x
        move around history list using j and k
    textual completion
        not part of standard vi
        type a word > hit ESC > hit \ 

    input to control mode
        hit ESC

    control to input mode
        hit i | a | I | A

    control to completion mode
        hit \



##########################
customize Unix environment
##########################

source executes the commands in specified file

~/.bash_logout
    read and executed every time a login shell exits
    useful if you want to execute some command that removes temp files

###############
~/.bash_profile
###############
# should be simple and just load .profile and .bashrc (in that order)

# get environment variables not specifically related to bash
if [ -f ~/.profile ]; then
    source ~/.profile
fi

# get aliases
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

##########
~/.profile
##########
# for stuff not specifically related to bash

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home
export PATH=$PATH:$JAVA_HOME/bin

export HADOOP_HOME=/Users/hduser/tools/hadoop-2.7.3
export PATH=$PATH:$HADOOP_HOME/bin

export PIG_HOME=/Users/hduser/tools/pig-0.17.0
export PATH=$PATH:$PIG_HOME/bin

#########
~/.bashrc
#########
# helpers for interactive command line work
# bash expands alias to actual text of the command before execution

# used brew to install vim
alias vim='/usr/local/bin/vim'

# avoid misspelling python all the time
alias p2='python'
alias p3='python3'


shell variables 
    variable=value
        no space on either side of the =
        if the value is more than 1 word then surround by quotes 

    to use the value of the variable use $variable

    $variable "survives" the double quotes when using echo
    
    $ $wonderland=alice
    $ echo $wonderland
    > alice
    $ echo "$wonderland"
    > alice

    need to use \$ if you want to echo the actual $ char
    also need to use \" to print quote char
    $ echo "The value of \$wonderland is \"$wonderland\"."
    > The value of $wonderland is "alice".
    
    when in doubt use single quotes
    unless a string contains a variable then use double quotes

PATH variable
    every command used is actually a file that contains code for your machine to run
    for builtin commands the code is part of the executable file for the shell itself
    these files are executable files
    often stored in a bin/ directory

    PATH helps the shell find the command you entered
    its value is a list of directories that the shell searches every time you enter a command
    dir names are separated by colons

    ############
    cat .profile
    ############
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home
    # places the $JAVA_HOME/bin as the next place to look for executable commands after default commands
    export PATH=$PATH:$JAVA_HOME/bin

    export HADOOP_HOME=/Users/hduser/tools/hadoop-2.7.3
    # places the $HADOOP_HOME/bin as the next place to look for executable commands after $JAVA_HOME/bin
    export PATH=$PATH:$HADOOP_HOME/bin

    export PIG_HOME=/Users/hduser/tools/pig-0.17.0
    # places the $PIG_HOME/bin as the next place to look for executable commands after $PIG_HOME/bin
    export PATH=$PATH:$PIG_HOME/bin
    ############

    when you enter a command the shell searches directories in the order they appear in PATH
    until executable file is found
    $ echo $PATH
    > /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/
    > Contents/Home/bin:/Users/hduser/tools/hadoop-2.7.3/bin:/Users/hduser/tools/pig-0.17.0/bin

    use type to find out where the executable is located
    $ echo hdfs
    > hdfs is /Users/hduser/tools/hadoop-2.7.3/bin/hdfs

environment variables
    whenever you enter a command you are telling the shell to run that command in a subprocess
    
    environment variables = special class of shell variables that can be accessed by all subprocesses

    any variable can become an environment variable
    by using the export command

    by adding this to my ~/.profile I can always refer to PIG_HOME
    $ export PIG_HOME=/Users/hduser/tools/pig-0.17.0



#######################
basic shell programming
#######################

$ chmod +x scriptname

ex: scriptname contains 2 commands: hatter and gryphon
$ source scriptname
    commands hatter and gryphon run in the same shell
    just as if you entered them directly into the command line

$ ./scriptname
    commands run in a subshell while the parent waits for the subshell to finish

$ ./scriptname &
    commands run in the background which really is another term for subprocess
    the only difference is you have control of your terminal while the commands run

if you did not export environment variables in the parent shell > they will not be accessible in the subshell

order of precedence for shared names
    alias
    keywords
    functions
    builtin functions
    scripts

    show everything associated with a word in its order of precedence
    $ type -all [word]

    $ type -t bash
    > file

    $ type -t if
    > keyword

functions
    when you define a function you tell the shell to store its name and definition in memory
    if you want to run a function later just type in its name followed by arguments as if it were a shell script

    $ declare -f 
        shows all functions and their definitions

    $ declare -F
        just shows function names

    functions do not run in separate processes 

shell variables
    value obtained by precending their number with a $
    environment variables are usually all caps (like I have it in .profile)
    bash places heavy emphasis on character strings

positional parameters
    $0 is the name of the script
    1 - 9 are the arguments passed to the script on the command line
    access in script via $1 - $9
    
