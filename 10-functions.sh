#!/bin/bash


#There are 4 tyes of commands

#1.Binary 
# 2. Alaiases
#3. Built in comands
#4 functions


# how to declare a function

# f () {
#    echo hai
#}

#How to call a function
 
# f calling a function

b56(){
    echo "This is our batch 56 function"
    echo "we are leaning function"
    echo "Today date is :"
    date 
    echo"function b56 is completed"
}

b56


stat(){
    
    echo "Number of session openend $(who|wc -1)"
    echo "Today date is $(date +%F)"
    echo  "avg cpu utlization  uptime|awk -F : '{print $NF}' | awk -F ',' '{print $2}'"
    b56
}