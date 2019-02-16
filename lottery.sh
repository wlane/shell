#!/bin/bash


function FrontGetLoto() {
    r=$((RANDOM%36))
    if [ $r -eq 0 ];then
		r=$((r+1))
	fi
	if [ $r -lt 9 ];then
		echo "0$r"
    else
        echo $r
	fi
}


function EndGetLoto() {
    r=$((RANDOM%13))
    if [ $r -eq 0 ];then
		r=$((r+1))
	fi
	if [ $r -lt 9 ];then
		echo "0$r"
    else
        echo $r
	fi
}

function FrontGetNumber() {
    m=$({ FrontGetLoto; FrontGetLoto; FrontGetLoto; FrontGetLoto; FrontGetLoto; } | sort -n)
    n=$(echo $m |tr ' ' '\n' |uniq -d)
    if [ -z $n ];then
        return 0
    else
        return 1
    fi
}


function EndGetNumber() {
    s=$({ EndGetLoto; EndGetLoto; } | sort -n)
    t=$(echo $s |tr ' ' '\n' |uniq -d)
    if [ -z $t ];then
        return 0
    else
        return 1
    fi
}


if [ $# -ne 1 ] || [ $1 -lt 1 -o $1 -gt 99 ];then
    echo "Usage: $0 [1-99]"
    exit
fi


i=1
while [ $i -le $1 ]
do
    FrontGetNumber
    if [ $? -ne 0 ];then
        continue
    fi

    EndGetNumber
    if [ $? -ne 0 ];then
        continue
    fi

    j=$i
    if [ $j -le 9 ];then
        echo -n "第0$j组: "
    else
        echo -n "第$j组: "
    fi

    echo $m $s
    i=$((i+1))
done