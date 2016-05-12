
ASCIIDOC_DIRS := docs

# all our asciidoc source files
ASCIIDOC_FILES := $(shell find $(ASCIIDOC_DIRS) -name '*.asciidoc')

# generate a list with suffix changed to .adoc
ADOC_FILES := $(patsubst %.asciidoc, %.adoc,  $(ASCIIDOC_FILES))

# rule to create a .adoc file from a .asciidoc file (same dir assumed)
# if the front matter changes, the .adoc files will be rebuilt
# remove extension in links containing .asciidoc for Jekyll
# remove lines containging all '=' characters
# fix links for includes and links to other pages
%.adoc: %.asciidoc  frontmatter.txt
	cat frontmatter.txt $< >$@
	sed -i '/^=\{5,\}=*$=/d' $@
# fix includes
	sed -i -e 's/\(^include::\)\(.*\)\(\.asciidoc\[.*\]\)/include::{{page.docs-dir}}\/\2\.adoc\[\]/g' $@
# fix links for Jekyll
	sed -i -e 's/\(link:\)\(.*\)\(\.asciidoc\)\(\[.*\]\)/link:..\/\2\4/g' $@
	sed -i -e 's/^:imagesdir: /:imagesdir: ..\//g' $@

# target - build the .adoc files
adoc-files:  $(ADOC_FILES)


# wipe the generated files
clean:
	find . -name '*.adoc'|xargs rm
