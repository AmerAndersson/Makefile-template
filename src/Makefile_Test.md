# Makefile for C Project with Debug, Release, Testing, and Coverage

# Define the C compiler
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

# Define the name of the executable
TARGET = results

# Define list of source and test files
SOURCES = main.c functions.c
TEST_SOURCES = main.c test.c functions.c


# Convert source files (.c) into object files (.o)
OBJECTS = $(SOURCES:%.c=%.o)
TEST_OBJECTS = $(TEST_SOURCES:%.c=%.o)

# Include dependencies
-include $(OBJECTS:.o=.d)

# Default target
default: all

# Default build
all: $(TARGET)

# Linking rule
$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $(TARGET)

# Compilation rule
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean rule
clean:
	rm -f $(OBJECTS) $(TARGET) *.o *.d *.gcda *.gcno coverage.info

# Rule to run the program
run: $(TARGET)
	./$(TARGET)

# Build explicitly in debug mode
debug:
	$(MAKE) BUILD=debug

# Build explicitly in release mode
release:
	$(MAKE) BUILD=release

# ====================
# UNIT TESTING SECTION
# ====================

# Unit test executable
TEST_EXEC = test_runner

# Test target
test: CFLAGS += --coverage
test: LDFLAGS += --coverage
test: $(TEST_EXEC)
	./$(TEST_EXEC)

# Linking rule for unit tests
$(TEST_EXEC): $(TEST_OBJECTS)
	$(CC) $(LDFLAGS) $(TEST_OBJECTS) -o $(TEST_EXEC) -lcunit

# =========================
# CODE COVERAGE SECTION
# =========================

# Generate coverage report
coverage: test
	gcov -b $(SOURCES) $(TEST_SOURCES)
	lcov --capture --directory . --output-file coverage.info
	genhtml coverage.info --output-directory coverage_report
	@echo "Open coverage_report/index.html in a browser."

# Phony targets
.PHONY: all clean run debug release test coverage
