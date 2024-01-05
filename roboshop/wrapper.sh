#!/bin/bash


bash components/$1.sh

if [ $? <> 0 ] ; then
    echo -e "\e[32m starting shipping service \e[0m"
   

fi