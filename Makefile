# see http://www.cmcrossroads.com/ask-mr-make/6535-tracing-rule-execution-in-gnu-make
# to trace make execution of make in more detail:
#     make VV=1
ifeq ("$(origin VV)", "command line")
    OLD_SHELL := $(SHELL)
    SHELL = $(warning Building $@$(if $<, (from $<))$(if $?, ($? newer)))$(OLD_SHELL)
endif
# Delete the default suffix rules
.SUFFIXES:
.PHONY: all

TEMPLATE:= $(shell pwd)/scripts/machinekit-docs.mustache

all:	docs/man/man1/index.asciidoc \
	docs/man/man3/index.asciidoc \
	docs/man/man9/index.asciidoc \
	docs/machinetalk/protobuf.asciidoc

# this should be made minimal
#	scripts/filenums


# all asciidoc documents in this repo
MAN1 := $(filter-out docs/man/man1/index.asciidoc, $(wildcard docs/man/man1/*.asciidoc))
MAN3 := $(filter-out docs/man/man3/index.asciidoc, $(wildcard docs/man/man3/*.asciidoc))
MAN9 := $(filter-out docs/man/man9/index.asciidoc, $(wildcard docs/man/man9/*.asciidoc))

docs/man/man1/index.asciidoc: $(MAN1)
	scripts/index-gen.sh man1 'HAL Utilities and GUIs'

docs/man/man3/index.asciidoc: $(MAN3)
	scripts/index-gen.sh man3 'RTAPI and HAL Functions'

docs/man/man9/index.asciidoc: $(MAN9)
	scripts/index-gen.sh man9 'HAL Components'

docs/machinetalk/protobuf.asciidoc: \
	machinetalk-protobuf/src/machinetalk/protobuf/*.proto \
	$(TEMPLATE) \
	machinetalk-protobuf/Makefile \
	scripts/gen-proto-docs.sh
	scripts/gen-proto-docs.sh  $(TEMPLATE)

