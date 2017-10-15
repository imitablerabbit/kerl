#!/bin/bash

# Display a spinner for the time that a process is alive for.
# This function should take 2 args, the first is the text that should
# appear next to the spinner, then the command that the spinner should execute.
display_spinner()
{
    TEXT=$1
    INDEX=1
    SPINNER="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
    shift
    ($@) &
    PID="$!"

    # Print the spinner on a single line for the duration of the command.
    tput sc
    while [ -d /proc/$PID ]
    do
        echo -ne "${SPINNER:INDEX++%${#SPINNER}:1} $TEXT"
        sleep 0.1
        tput el1
        tput rc
    done

    # Return the same as the command run
    return `wait $PID`
}

display_spinner "Hello" "sleep 5"
display_spinner "Doing stuff" sleep 2
display_spinner "Goodbye" sleep 4
