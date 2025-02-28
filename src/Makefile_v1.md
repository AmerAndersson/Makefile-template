# Makefile Tutorial for C Language

# Define the C compiler to use
CC = gcc

# Default build mode (can be overridden by calling `make BUILD=release`)
BUILD ?= debug

# Define compiler flags for different build types
ifeq ($(BUILD),debug)
    CFLAGS = -W -Wall -ansi -Wextra -pedantic-errors -g -std=c11 -MMD -MP
    LDFLAGS = -Wall -lm
else ifeq ($(BUILD),release)
    CFLAGS = -W -Wall -ansi -Wextra -pedantic-errors -O2 -std=c11 -MMD -MP
    LDFLAGS = -Wall -lm
endif

# Define the name (target) of the executable
TARGET = results

# Define list of source files
SOURCES = main.c functions.c

# Convert source files (.c) into object files (.o)
OBJECTS = $(SOURCES:%.c=%.o)

# Include dependencies
-include $(OBJECTS:.o=.d)

# Default target
default: all

# Default build (compiles in debug mode unless specified otherwise)
all: $(TARGET)

# Linking rule
$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $(TARGET)

# Compilation rule
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean rule
clean:
	rm -f $(OBJECTS) $(TARGET) *.d

# Rule to run the program
run: $(TARGET)
	./$(TARGET)

# Build explicitly in debug mode
debug:
	$(MAKE) BUILD=debug

# Build explicitly in release mode
release:
	$(MAKE) BUILD=release

# Phony targets
.PHONY: all clean run debug release
