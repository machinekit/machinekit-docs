#!/bin/sh
# $1 = directory to output to

mkdir -p $1/man1
for i in docs/man/man1/*.asciidoc ; do
    compname=$(basename -s .asciidoc "$i") ;
    if [ $compname != "index" ] ; then        
	ln -s -f /usr/share/man/man1/machinekit.1 $1/man1/$compname.1	
    fi
done

mkdir -p $1/man3
for i in docs/man/man3/*.asciidoc ; do
    compname=$(basename -s .asciidoc "$i") ;
    if [ $compname != "index" ] ; then        
	ln -s -f /usr/share/man/man1/machinekit.1 $1/man3/$compname.3
    fi
done

mkdir -p $1/man9
for i in docs/man/man9/*.asciidoc ; do
    compname=$(basename -s .asciidoc "$i") ;
    if [ $compname != "index" ] ; then        
	ln -s -f /usr/share/man/man1/machinekit.1 $1/man9/$compname.9
    fi
done

echo "Links created in $1"


