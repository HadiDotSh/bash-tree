#!/bin/bash
# Bash Tree
# By @HadiDotSh
# A lot of stuff need to be done..

tab=0
clear
[[ -z ${1} ]] && path=$(pwd) || path="${1}"
cd $path
printf "\e[1;90m$path\n│\n\e[0;0m"

function niceTab(){
    if [[ $empty == true ]];then
        for (( i=1 ; i<tab ; i++ ));do
            printf "  "
        done       
        printf "\e[1;90m│\e[0;0m  "
    else
    
        for (( i=0 ; i<tab ; i++ ));do
            printf "\e[1;90m│\e[0;0m  "
        done       
    fi
}

function tree(){
    local tab=$1
    local empty=$2
    shift
    shift
    local files=$*
    local nfile=0
    for file in $files;do
        let nfile++
    done
    local n=1
    for file in $files;do

        if [[ $n -lt $nfile ]];then
            niceTab
            [[ -d $file ]] && printf "\e[1;90m├─\e[1;0m \e[1;93m$file\e[0;0m\n" || printf "\e[1;90m├─\e[1;0m \e[1;77m$file\e[0;0m\n"

        elif [[ $n -eq $nfile ]];then

            niceTab
            [[ -d $file ]] && printf "\e[1;90m└─\e[1;0m \e[1;93m$file\e[0;0m\n" || printf "\e[1;90m└─\e[1;0m \e[1;77m$file\e[0;0m\n"

        fi

        if [[ -d $file && $n -eq $nfile ]];then
            cd $file
            tree $((tab+1)) false $( ls )
        elif [[ -d $file ]];then
            cd $file
            tree $((tab+1)) false $( ls )      
        fi

        let n++
    done

    cd ..
}

tree 0 false $(ls)