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

all:
	scripts/index-gen.sh man1 'HAL Utilities and GUIs'
	scripts/index-gen.sh man3 'RTAPI and HAL Functions'
	scripts/index-gen.sh man9 'HAL Components'
	scripts/filenums
	
