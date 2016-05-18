#!/usr/bin/python

import sys
import frontmatter
import yaml
import re
import codecs

try:
    name = sys.argv[1]
    document = frontmatter.load(name)

    # avoid converting files which seem to be asciidoc with frontmatetr
    # already
    if document.metadata:
        print "document metadata not empty: ", document.metadata
        sys.exit(1)

    # how to add to frontmatter
    #document['page-source'] = name

    # avoid converting files which already have :skip-front-matter:
    pattern = re.compile(':skip-front-matter:')
    if not pattern.match(document.content):
        f = open(name, "w")
        f.truncate()
        f.write( "---\n---\n:skip-front-matter:\n\n" + document.content.encode('ascii', 'ignore'))
        f.close
    else:
        print "document already has :skip-front-matter:, not rewriting"
except Exception,e:
    print "error converting file %s : %s" % (name, str(e))

