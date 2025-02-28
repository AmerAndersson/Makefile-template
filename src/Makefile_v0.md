# Makefile Tutorial for C Language

# Define the C compiler to use
CC=gcc
DEBUG=yes

# Define compiler flags:
ifeq ($(DEBUG),yes)
    CFLAGS=-W -Wall -ansi -Wextra -pedantic-errors -g -std=c11 -MMD -MP
else
    CFLAGS=-W -Wall -ansi -Wextra -pedantic-errors -std=c11 -MMD -MP
endif

LDFLAGS= -Wall -lm

# Define the name (target) of the executable
TARGET=results

# Define list of source files
SOURCES = main.c functions.c

# Convert source files (.c) into object files (.o)
OBJECTS = $(SOURCES:%.c=%.o)

# Include dependencies
-include $(OBJECTS:.o=.d)

# Default target
default: all

all: $(TARGET)

# Linking rule
$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $(TARGET) $(LIBS)

# Compilation rule
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean rule
clean:
	rm -f $(OBJECTS) $(TARGET) *.d

# Rule to run the program
run: $(TARGET)
	./$(TARGET)

# Phony targets
.PHONY: all clean run
