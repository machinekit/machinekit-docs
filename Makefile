

ASCIIDOC_DIRS := docs src

# all our asciidoc source files
ASCIIDOC_FILES := $(shell find $(ASCIIDOC_DIRS) -name '*.asciidoc')

# generate a list with suffix changed to .adoc
ADOC_FILES := $(patsubst %.asciidoc, %.adoc,  $(ASCIIDOC_FILES))

# rule to create a .adoc file from a .asciidoc file (same dir assumed)
# if the front matter changes, the .adoc files will be rebuilt
%.adoc: %.asciidoc  frontmatter.txt
	cat frontmatter.txt $< >$@
	sed -i -e 's/.asciidoc\[/\[/g' $@

# target - build the .adoc files
adoc-files:  $(ADOC_FILES)


# wipe the generated files
clean:
	find . -name '*.adoc'|xargs rm
