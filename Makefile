#
# OMNeT++/OMNEST Makefile for libChannels
#
# This file was generated with the command:
#  opp_makemake -f --deep --make-so -O out -L../DHCP/out/$(CONFIGNAME)/src -L../inetmanet/out/$(CONFIGNAME)/src -lDHCP -linet -KDHCP_PROJ=../DHCP -KINETMANET_PROJ=../inetmanet
#

# Name of target to be created (-o option)
TARGET = libChannels$(SHARED_LIB_SUFFIX)

# C++ include paths (with -I)
INCLUDE_PATH = -I. -Iexamples -Iexamples/MeasuringThroughput -Isrc

# Additional object and library files to link with
EXTRA_OBJS =

# Additional libraries (-L, -l options)
LIBS = -L../DHCP/out/$(CONFIGNAME)/src -L../inetmanet/out/$(CONFIGNAME)/src  -lDHCP -linet
LIBS += -Wl,-rpath,`abspath ../DHCP/out/$(CONFIGNAME)/src` -Wl,-rpath,`abspath ../inetmanet/out/$(CONFIGNAME)/src`

# Output directory
PROJECT_OUTPUT_DIR = out
PROJECTRELATIVE_PATH =
O = $(PROJECT_OUTPUT_DIR)/$(CONFIGNAME)/$(PROJECTRELATIVE_PATH)

# Object files for local .cc and .msg files
OBJS = $O/src/LinkFailureManager.o $O/src/MyThroughputMeteringChannel.o $O/src/ProgramedFailureChannel.o $O/src/LinkFailureMessage_m.o

# Message files
MSGFILES = \
    src/LinkFailureMessage.msg

# Other makefile variables (-K)
DHCP_PROJ=../DHCP
INETMANET_PROJ=../inetmanet

#------------------------------------------------------------------------------

# Pull in OMNeT++ configuration (Makefile.inc or configuser.vc)

ifneq ("$(OMNETPP_CONFIGFILE)","")
CONFIGFILE = $(OMNETPP_CONFIGFILE)
else
ifneq ("$(OMNETPP_ROOT)","")
CONFIGFILE = $(OMNETPP_ROOT)/Makefile.inc
else
CONFIGFILE = $(shell opp_configfilepath)
endif
endif

ifeq ("$(wildcard $(CONFIGFILE))","")
$(error Config file '$(CONFIGFILE)' does not exist -- add the OMNeT++ bin directory to the path so that opp_configfilepath can be found, or set the OMNETPP_CONFIGFILE variable to point to Makefile.inc)
endif

include $(CONFIGFILE)

# Simulation kernel and user interface libraries
OMNETPP_LIB_SUBDIR = $(OMNETPP_LIB_DIR)/$(TOOLCHAIN_NAME)
OMNETPP_LIBS = -L"$(OMNETPP_LIB_SUBDIR)" -L"$(OMNETPP_LIB_DIR)" -loppenvir$D $(KERNEL_LIBS) $(SYS_LIBS)

COPTS = $(CFLAGS)  $(INCLUDE_PATH) -I$(OMNETPP_INCL_DIR)
MSGCOPTS = $(INCLUDE_PATH)

#------------------------------------------------------------------------------
# User-supplied makefile fragment(s)
# >>>
# <<<
#------------------------------------------------------------------------------

# Main target
all: $(TARGET)

$(TARGET) : $O/$(TARGET)
	$(LN) $O/$(TARGET) .

$O/$(TARGET): $(OBJS)  $(wildcard $(EXTRA_OBJS)) Makefile
	@$(MKPATH) $O
	$(SHLIB_LD) -o $O/$(TARGET)  $(OBJS) $(EXTRA_OBJS) $(LIBS) $(OMNETPP_LIBS) $(LDFLAGS)
	$(SHLIB_POSTPROCESS) $O/$(TARGET)

.PHONY:

.SUFFIXES: .cc

$O/%.o: %.cc
	@$(MKPATH) $(dir $@)
	$(CXX) -c $(COPTS) -o $@ $<

%_m.cc %_m.h: %.msg
	$(MSGC) -s _m.cc $(MSGCOPTS) $?

msgheaders: $(MSGFILES:.msg=_m.h)

clean:
	-rm -rf $O
	-rm -f Channels Channels.exe libChannels.so libChannels.a libChannels.dll libChannels.dylib
	-rm -f ./*_m.cc ./*_m.h
	-rm -f examples/*_m.cc examples/*_m.h
	-rm -f examples/MeasuringThroughput/*_m.cc examples/MeasuringThroughput/*_m.h
	-rm -f src/*_m.cc src/*_m.h

cleanall: clean
	-rm -rf $(PROJECT_OUTPUT_DIR)

depend:
	$(MAKEDEPEND) $(INCLUDE_PATH) -f Makefile -P\$$O/ -- $(MSG_CC_FILES)  ./*.cc examples/*.cc examples/MeasuringThroughput/*.cc src/*.cc

# DO NOT DELETE THIS LINE -- make depend depends on it.
$O/src/LinkFailureMessage_m.o: src/LinkFailureMessage_m.cc \
	src/LinkFailureMessage_m.h \
	src/LinkFailureManager.h
$O/src/MyThroughputMeteringChannel.o: src/MyThroughputMeteringChannel.cc \
	src/MyThroughputMeteringChannel.h
$O/src/LinkFailureManager.o: src/LinkFailureManager.cc \
	src/ProgramedFailureChannel.h \
	src/LinkFailureMessage_m.h \
	src/LinkFailureManager.h
$O/src/ProgramedFailureChannel.o: src/ProgramedFailureChannel.cc \
	src/ProgramedFailureChannel.h \
	src/LinkFailureManager.h

