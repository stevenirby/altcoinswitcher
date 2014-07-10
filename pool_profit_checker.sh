#!/bin/bash
set -x

rootdir='/home/miner'

wget --no-cache --load-cookies $rootdir/cookies.txt http://wafflepool.com/stats?$(( ( RANDOM % 1000 )  + 1 )) -O $rootdir/test.html

scrypt=`grep -m 1 -A 3 '<b>scrypt' $rootdir/test.html | grep -E -o [0-9]+*% | sed 's/%//'`
nscrypt=`grep -m 1 -A 3 'nscrypt' $rootdir/test.html | grep -E -o [0-9]+*% | sed 's/%//'`
x11=`grep -m 2 -A 3 'x11' $rootdir/test.html | grep -E -o [0-9]+*% | sed 's/%//'`
x13=`grep -m 2 -A 3 '<b>x13' $rootdir/test.html | grep -E -o [0-9]+*% | sed 's/%//'`


types=( 'cgminer' 'nscrypt' 'x11' 'x13' )
ar=( $scrypt $nscrypt $x11 $x13 )

max=0
index=0
arLen=${#ar[@]}
maxoffset=0

# loop over the values for all typess
# set the max number and index
for (( i=0; i<${arLen}; i++ ));
    do
    if (( ${ar[$i]} > $max ));
        then
            max=${ar[$i]};
            index=$i;
    fi;
done

# the name of the types `echo ${types[$index]}`

name=${types[$index]}
echo $name
timestamp=`date +'%b %d %H:%M:%S'`

if [[ $name == 'x11' ]]
    then
        search_string='kernel=x11';
else
        search_string=$name;
fi

if `ps aux | grep -v 'grep' | grep -v -i 'screen' | grep -q $search_string`;
    then
        echo $timestamp 'Woot! mining the most profitable coins...' >> $rootdir/cgmon.log;
else
        echo $timestamp ' Not mining most profitable coin! ' $search_string >> $rootdir/cgmon.log;
        pid=`ps aux | grep -v 'grep' | grep -v -i 'screen' | grep ${types[0]} | awk '{print $2}'`;
        echo $pid
        kill $pid;
	sleep 1
        pid=`ps aux | grep -v 'grep' | grep -v -i 'screen' | grep ${types[1]} | awk '{print $2}'`;
        echo $pid
        kill $pid;
	sleep 1
        pid=`ps aux | grep -v 'grep' | grep -v -i 'screen' | grep ${types[2]} | awk '{print $2}'`;
        echo $pid
        kill $pid;
	sleep 1
        pid=`ps aux | grep -v 'grep' | grep -v -i 'screen' | grep ${types[3]} | awk '{print $2}'`;
        echo $pid
        kill $pid;
	sleep 1
        cp $rootdir/$name'.tcl' $rootdir/cgmon.tcl;
        echo $timestamp 'Switching to ' $name ' config'; >> $rootdir/cgmon.log;
fi

exit
