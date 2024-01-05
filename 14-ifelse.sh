#!/bin/shell

echo -e "Demo on if ,if else & else if usage"

ACTION=$1

if [ "$ACTION" ==  start ] ; then
    echo -e "\e[32m starting shipping service \e [0m"
    exit 0

else

   echo -e "\e[33m valid option is start only \e [0m"
    exit 1


fi

 echo  "it has not met any contion"
 exit 100