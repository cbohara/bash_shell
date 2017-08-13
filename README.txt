Notes from Learning the Bash Shell by Cameron Newham and Bill Rosenblatt

#####
Intro
#####

shell = user interface with the OS
any program that takes input from the user > translates instructions to OS > convey OS output back to user

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
Command line editing 
####################

“Why can’t I edit my UNIX command lines in the same way I can edit text with an editor?”
you can with bash!

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
