#!/bin/bash
#Author: CaptainCluster https://github.com/CaptainCluster

#Makes sure that the pattern the user gives is valid.
#We will define invalid patterns based on how dangerous they can be.
checkPattern(){
    pattern=$1
    minLength=3 #The pattern must have at least 3 letters
    if [[ "${#pattern}" -lt "$minLength" ]]; then 
        condition="false"
    else
        condition="true"
    fi
    printf "$condition" #Returning either "true" or "false"
}