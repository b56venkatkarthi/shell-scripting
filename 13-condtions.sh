#!/bin/shell

# syntax of case

#case $var in

#opt1) command -x ;;
#opt2) command -y ;;

#esac

ACTION=$1   # &1 refrs first command line argument

case $ACTION in
    start)
       echo -e "\e[32m statrting shipping service \e[0m"
       exit 0
       ;;
    stop)
        echo -e "\e[32m stoping new shipping service \e[0m"
        exit 1
        ;;
    restart)
        echo -e "\e[33m Restarting new shipping service \e[0m"
        exit 3
        ;;
    *)
        echo -e  "\e[35m valid options are start or stop or restart only \e[0m"
        echo -e  "\e[33m Example usage : \e[0m \n\t\t bash script.sh start"
esac