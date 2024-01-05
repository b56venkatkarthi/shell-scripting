#!/bin/bash


bash components/$1.sh

if [ $? <> 0 ] ; then
    echo -e "\e[32m example usage : \e[0m bash wrapper.sh componenName"
   exit 30

fi