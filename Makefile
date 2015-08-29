#
#  Protobuf support for machinekit
#
#  generate Python modules, and C++ bindings from .proto files

# see http://www.cmcrossroads.com/ask-mr-make/6535-tracing-rule-execution-in-gnu-make
# to trace make execution of make in more detail:
#     make VV=1
ifeq ("$(origin VV)", "command line")
    OLD_SHELL := $(SHELL)
    SHELL = $(warning Building $@$(if $<, (from $<))$(if $?, ($? newer)))$(OLD_SHELL)
endif

ifeq ("$(origin V)", "command line")
  BUILD_VERBOSE = $(V)
endif
ifndef BUILD_VERBOSE
  BUILD_VERBOSE = 0
endif
ifeq ($(BUILD_VERBOSE),1)
  Q =
else
  Q = @
endif
ECHO := @echo

# all protobuf definitions live here
SRCDIR := src
PROTODIR := $(SRCDIR)/machinetalk/protobuf


# generated C++ headers + source files
CXXGEN   := generated

# generated Python files
PYGEN    := python

# generated Documentation files
DOCGEN := doc

# disable protobuf.js per default
PROTOBUFJS := 0

# directory for ProtoBuf.js generated files
PROTOBUFJS_GEN := js

# the proto2js compiler
PROTOJS := $(shell which proto2js)

# pkg-config
PKG_CONFIG := $(shell which pkg-config)

# proto2js options - namespace
#PROTOBUFJS_OPT := -commonjs=pb
# http://en.wikipedia.org/wiki/Asynchronous_module_definition
#PROTOBUFJS_OPT := -amd
PROTOBUFJS_OPT := -class

# protobuf namespace; all protos except nanopb.proto
JSNAMESPACE := =pb

# the set of all proto specs generated files depend on
PROTO_SPECS := $(wildcard $(PROTODIR)/*.proto)

# the protobuf compiler
PROTOC := $(shell which protoc)

# the directory where descriptor.proto lives:
GPBINCLUDE :=  $(shell $(PKG_CONFIG) --variable=includedir protobuf)
DESCDIR    :=  $(GPBINCLUDE)/google/protobuf

# object files generated during dependency resolving
OBJDIR := objects

# search path for .proto files
# see note on PBDEP_OPT below
vpath %.proto  $(PROTODIR):$(GPBINCLUDE):$(DESCDIR)/compiler

# machinetalk/proto/*.proto derived Python bindings
PROTO_PY_TARGETS := ${PROTO_SPECS:$(SRCDIR)/%.proto=$(PYGEN)/%_pb2.py}

PROTO_DOC_TARGETS += $(subst $(PROTODIR)/, \
	$(DOCGEN)/, \
	$(patsubst %.proto, %.md, $(PROTO_SPECS)))

# generated C++ includes
PROTO_CXX_INCS := ${PROTO_SPECS:$(SRCDIR)/%.proto=$(CXXGEN)/%.pb.h}

# generated C++ sources
PROTO_CXX_SRCS  :=  ${PROTO_SPECS:$(SRCDIR)/%.proto=$(CXXGEN)/%.pb.cc}

# generated Javasript sources
PROTO_PROTOBUFJS_SRCS  := ${PROTO_SPECS:$(SRCDIR)/%.proto=$(PROTOBUFJS_GEN)/%.js}


# ---- generate dependcy files for .proto files
#
# the list of .d dep files for .proto files:
PROTO_DEPS :=  ${PROTO_SPECS:$(SRCDIR)/%.proto=$(OBJDIR)/%.d}

#
# options to the dependency generator protoc plugin
PBDEP_OPT :=
#PBDEP_OPT += --debug
PBDEP_OPT += --cgen=$(CXXGEN)
PBDEP_OPT += --pygen=$(PYGEN)
PBDEP_OPT += --jsgen=$(PROTOBUFJS_GEN)
# this path must match the vpath arrangement exactly or the deps will be wrong
# unfortunately there is no way to extract the proto path in the code
# generator plugin
PBDEP_OPT += --vpath=$(SRCDIR)
PBDEP_OPT += --vpath=$(GPBINCLUDE)
PBDEP_OPT += --vpath=$(DESCDIR)/compiler


GENERATED += \
	$(PROTO_CXX_SRCS)\
	$(PROTO_CXX_INCS) \
	$(PROTO_PY_TARGETS)

ifeq ($(PROTOBUFJS),1)
GENERATED += $(PROTO_PROTOBUFJS_SRCS) $(PROTOBUFJS_GEN)/nanopb.js
endif

$(OBJDIR)/%.d: $(SRCDIR)/%.proto
	$(ECHO) "protoc create dependencies for $<"
	@mkdir -p $(OBJDIR)/
	$(Q)$(PROTOC) \
		--plugin=protoc-gen-depends=scripts/protoc-gen-depends \
		--proto_path=$(SRCDIR)/ \
		--proto_path=$(GPBINCLUDE)/ \
		--depends_out="$(PBDEP_OPT)":$(OBJDIR)/ \
		 $<

#---------- C++ rules -----------
#
# generate .cc/.h from proto files
# for command.proto, generated files are: command.pb.cc	command.pb.h
$(CXXGEN)/%.pb.cc $(CXXGEN)/%.pb.h: $(SRCDIR)/%.proto
	$(ECHO) "protoc create $@ from $<"
	@mkdir -p $(CXXGEN)
	$(Q)$(PROTOC) $(PROTOCXX_FLAGS) \
	--proto_path=$(SRCDIR)/ \
	--proto_path=$(GPBINCLUDE)/ \
	--cpp_out=$(CXXGEN) \
	$<

# ------------- Python rules ------------
#
# this is for the stock protobuf Python bindings -
# adapt here if using one of the accelerated methods
#
# generate Python modules from proto files
$(PYGEN)/%_pb2.py: $(SRCDIR)/%.proto
	$(ECHO) "protoc create $@ from $<"
	@mkdir -p $(PYGEN)
	$(Q)$(PROTOC) $(PROTOC_FLAGS) \
		--proto_path=$(SRCDIR)/ \
		--proto_path=$(GPBINCLUDE)/ \
		--python_out=$(PYGEN)/ \
		$<

# ------------- protoc-gen-doc rules ------------
#
# see https://github.com/estan/protoc-gen-doc
#
# generate Markdown files from proto files
$(DOCGEN)/%.md: %.proto
	$(ECHO) "protoc create $@ from $<"
	@mkdir -p $(DOCGEN)
	$(Q)$(PROTOC) $(PROTOC_FLAGS) \
	--proto_path=$(PROTODIR)/ \
	--proto_path=$(GPBINCLUDE)/ \
	--doc_out=markdown,$@:./ \
	$<

# ------------- ProtoBuf.js rules ------------
#
# see https://github.com/dcodeIO/ProtoBuf.js
#
# generate Javascript modules from proto files
#=$(filter-out %/butterfly.ngc,$(call GLOB,../nc_files/*))

$(PROTOBUFJS_GEN)/%.js: %.proto
	$(ECHO) $(PROTOJS)" create $@ from $<"
	@mkdir -p $(PROTOBUFJS_GEN)
	$(Q)$(PROTOJS) 	$< \
	$(PROTOBUFJS_OPT)$(JSNAMESPACE) \
	> $@

# everything is namespace pb except nanopb.proto
# # nanopb.proto needs different opts - no namespace argument
$(PROTOBUFJS_GEN)/nanopb.js: $(PROTODIR)/nanopb.proto
	# $(ECHO) "HALLO"
	# $(ECHO) $(PROTOJS)" create $@ from $<"
	@mkdir -p $(PROTOBUFJS_GEN)
	$(Q)$(PROTOJS) 	$< \
	$(PROTOBUFJS_OPT) \
	> $@

# force create of %.proto-dependent files and their deps
Makefile: $(GENERATED) $(PROTO_DEPS)
-include $(PROTO_DEPS)

all: $(GENERATED) $(PROTO_DEPS)

ios_replace:
	sh scripts/ios-replace.sh $(CXXGEN)

docs: $(PROTO_DEPS) $(PROTO_DOC_TARGETS)

clean:
	rm -rf $(OBJDIR) $(CXXGEN) $(PYGEN)/**_pb2.py $(PROTO_PROTOBUFJS_SRCS) $(DOCGEN)
