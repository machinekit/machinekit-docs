#!/bin/bash -e


DOCNAME=protobuf.asciidoc
PB_DOCDIR=docs/machinetalk/

cd machinetalk-protobuf

# this will generate machinetalk-protobuf/protobuf.asciidoc
make V=1 docs DOCFORMAT=asciidoc DOCEXT=asciidoc DOC_TARGET=${DOCNAME} TEMPLATE=$1

mkdir -p ../${PB_DOCDIR} || /bin/true

# update only if they differ
cmp --silent ../${PB_DOCDIR}/${DOCNAME}  ${DOCNAME} || (echo "files differ - updating ${DOCNAME}"; cp ${DOCNAME} ../${PB_DOCDIR})

