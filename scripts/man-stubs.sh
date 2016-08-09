#!/bin/sh

mkdir -p docs/man/man1/links
for i in docs/man/man1/*.asciidoc ; do
    compname=$(basename -s .asciidoc "$i") ;
    if [ $compname != "index" ] ; then        
	ln -s -f /usr/share/man/man1/machinekit.1 docs/man/man1/links/$compname.1	
    fi
done

mkdir -p docs/man/man3/links
for i in docs/man/man3/*.asciidoc ; do
    compname=$(basename -s .asciidoc "$i") ;
    if [ $compname != "index" ] ; then        
	ln -s -f /usr/share/man/man1/machinekit.1 docs/man/man3/links/$compname.3
    fi
done

mkdir -p docs/man/man9/links
for i in docs/man/man9/*.asciidoc ; do
    compname=$(basename -s .asciidoc "$i") ;
    if [ $compname != "index" ] ; then        
	ln -s -f /usr/share/man/man1/machinekit.1 docs/man/man9/links/$compname.9
    fi
done

echo "Links created"


