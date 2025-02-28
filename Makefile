########################################################################
####################### Makefile Template ##############################
########################################################################

# The C Compiler settings to use - Can be customized.
CC = gcc

# Default build mode (can be overridden by calling `make BUILD=release`)
BUILD ?= debug

# Define compiler flags for different build types
ifeq ($(BUILD),debug)
    CFLAGS = -W -Wall -ansi -Wextra -pedantic-errors -g -std=c23 -MMD -MP
    LDFLAGS = -lm
else ifeq ($(BUILD),release)
    CFLAGS = -W -Wall -ansi -Wextra -pedantic-errors -O3 -std=c23 -MMD -MP
    LDFLAGS = -lm
endif

# Makefile settings - Can be customized.
APPNAME = results
TARGET = .c
SRCDIR = src
BUILDDIR = build
OBJDIR = $(BUILDDIR)/obj

############## Do not change anything from here downwards! #############

# Create directories if they don't exist
$(shell mkdir -p $(OBJDIR))

SRC = $(wildcard $(SRCDIR)/*$(TARGET))
OBJ = $(SRC:$(SRCDIR)/%$(TARGET)=$(OBJDIR)/%.o)
DEP = $(OBJ:$(OBJDIR)/%.o=%.d)

# UNIX-based OS variables & settings
RM = rm -f

########################################################################
####################### Targets beginning here #########################
########################################################################

all: $(BUILDDIR)/$(APPNAME)

# Builds the app
$(BUILDDIR)/$(APPNAME): $(OBJ)
	$(CC) $(LDFLAGS) $(OBJ) -o $@

# Creates the dependency rules
$(OBJDIR)/%.d: $(SRCDIR)/%$(TARGET)
	$(CC) $(CFLAGS) -MM -MT $(OBJDIR)/$*.o $< > $@

# Includes all .d files
-include $(DEP)

# Building rule for .o files and its .c/.cpp in combination with all .h
$(OBJDIR)/%.o: $(SRCDIR)/%$(TARGET)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to run the program
run: $(BUILDDIR)/$(APPNAME)
	./$(BUILDDIR)/$(APPNAME)

# Build explicitly in debug mode
debug:
	$(MAKE) BUILD=debug

# Build explicitly in release mode
release:
	$(MAKE) BUILD=release

################### Cleaning rules for Unix-based OS ###################
# Cleans complete project
.PHONY: clean
clean:
	$(RM) -r $(BUILDDIR)

# Cleans only all files with the extension .d
.PHONY: cleandep
cleandep:
	$(RM) $(DEP)

# Phony targets
.PHONY: all run debug release