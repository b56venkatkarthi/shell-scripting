#!/bin/shell

echo -e "Demo on if ,if else & else if usage"

ACTION=$1

if [ $ACTION == start ] ; then
    echo -e "\e[32m starting shipping service \e [0m"
    exit 0

fi