#!/bin/shell

# syntax of case

#case $var in

#opt1) command -x ;;
#opt2) command -y ;;

#esac


ACTION=$1   # &1 refrs first command line argument

case

start )
ehco -e "\e [32 m statrting shipping service \e[0m"
exit 0
;;
stop)

echo -e  "\e[32 m stoping new shipping service \e[0m"
exit1
;;
restart)
echo -e  "\e[33 m Restarting new shipping service \e[0m"
exit2
;;
*)
echo -e  "\e[35 m valid options are start or stop or restart only \e[0m"
echo -e  "\e[33 m Example usage : \e[0m bash script.sh start"

esac