# Makefile Tutorial for C Language

# Define the C compiler to use
CC=gcc
DEBUG=yes

# Define compiler flags:
# -g for debugging
# -Wall to get all the possible warnings
# -ansi -pendantic to get portable code
ifeq ($(DEBUG),yes)
    CFLAGS=-W -Wall -ansi -Wextra -pedantic-errors -g -std=c11
    LDFLAGS= -Wall -lm
else
    CFLAGS=-W -Wall -ansi -Wextra -pedantic-errors -std=c11
    LDFLAGS= -Wall -lm
endif

# Libraries to link with (none for the moment)
LIBS =

# Define the name (target) of the executable
TARGET=results

# Define list of source files
SOURCES = main.c functions.c

# Convert source files (.c) into object files (.o) 
OBJECTS = $(SOURCES:%.c=%.o)

# The first target, this will be the default target if none is specified
# This target tells "make" to make the "all" target
default: all

# Default target (first target executed when running `make`)
all: $(TARGET)

# Default rule to link object files into the final executable
$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $(TARGET) $(LIBS)


# Rule to compile each .c file into an .o file
# CFLAGS in Compilation Rule Only
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to clean up object files and the executable
clean:
	rm -f $(OBJECTS) $(TARGET) *.o # Remove the object files and the executable file.

# Rule to run the program
run: $(TARGET)
	./$(TARGET)

# Phony targets (they don't represent actual files)
.PHONY: all clean run

# Finally we need to tell "make" what source and header file each object file depends on
# main.o: main.c


