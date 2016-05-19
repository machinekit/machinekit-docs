#!/bin/sh
# `scripts/index-gen <man-sub-dir> <man-page-type>`
# eg. 
# `scripts/index-gen man9 'HAL Component'

DOC="docs/man/$1/index.asciidoc"

touch $DOC
echo "---" > $DOC
echo "---" >> $DOC
echo ":skip front matter:"  >> $DOC

echo "\n= $2 Man Pages\n\n" >> $DOC
echo "" >> $DOC
for i in docs/man/$1/*.asciidoc ; do
    compname=$(basename -s .asciidoc "$i") ;
    if [ $compname != "index" ] ; then        
	echo "- link:http://preview.machinekit.io/docs/man/$1/$compname[$compname]\n\n" >> $DOC    
    fi
done
echo "" >> $DOC
echo "Automatically generated index at: $(date)" >> $DOC
