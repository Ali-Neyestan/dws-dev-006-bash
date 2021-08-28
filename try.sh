#!/bin/bash
count=1

### call when an error occurred

function usage {
    echo "Usage: $0 -i [interval] -n [numbers] command"
    exit 1;
}


### read the &5 and after that if the command has 2 section
### like ping 4.2.2.4
command=${*:5}

### if condition to get the necessary options
if [ -e $1 ] & [ -e $3 ]; then
    usage
fi

### getting option
case $1 in
    -i)
        interval=$2
        ;;
    *)
        usage
        ;;
esac
case $3 in
    -n)
        number=$4
        ;;
    *)
        usage
        ;;
esac

### if condition to check the command if it's empty
if [ -z "$command" ]; then
    usage
    exit 1;
fi

while true; do
eval $command
    if [[ $? -eq 0 ]]; then
        echo "exit $?"
        exit $?;
    fi
    if [[ $count -ge $number ]]; then
        echo "Command Failed after retrying $number times" > /dev/stderr
        exit 1;
    else
        echo "Command Failed retrying in $interval"
        sleep $interval
        let "count+=1"
    fi
done

    