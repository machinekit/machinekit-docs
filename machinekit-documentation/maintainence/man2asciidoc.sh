#!/bin/sh

DOC="index-instantiated-components.asciidoc"

touch $DOC
echo "= Index of Instantiated HAL Components\n\n" > $DOC

echo "The essential difference between normal realtime components and instantiable components,\n" >> $DOC
echo "is that 'normal components' are loaded once only and have to create as many copies of the\n" >> $DOC
echo "component as they need, all at once, there and then.\n\n" >> $DOC

echo "Instantiable components load the 'base component' and from that can create instances.\n" >> $DOC
echo "of the component whenever they are required.\n" >> $DOC
echo "So instances can be created in separate hal files, on-the-fly or whatever.\n" >> $DOC
echo "Amoungst many advantages, it opens up huge flexibility in configuration.\n\n" >> $DOC

echo "Further info link:../src/hal/new-instantiated-components.asciidoc[here]\n\n" >> $DOC

echo "== The available Instantiated HAL Components are:\n\n" >> $DOC

mkdir components

for i in $EMC2_HOME/src/hal/i_components/*.icomp ; do
    compname=$(basename -s .icomp "$i") ;
    man $EMC2_HOME/man/man9/$compname.9icomp > $compname.txt ;
    pandoc -s -S $compname.txt -t asciidoc -o $compname.asciidoc ;
    mv $compname.asciidoc components/$compname.asciidoc ;
    rm $compname.txt
    echo "- link:components/$compname.asciidoc[$compname]\n\n" >> $DOC    
done

echo "=== This listing is manually generated when new components are added or removed\n" >> $DOC

echo "To ensure your copy repo is up to date, do frequent pulls from the machinekit-docs master repo\n" >> $DOC
