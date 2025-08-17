# src/Makefile

# Platform detection
ifeq ($(shell uname -s),Darwin)
CONFIG_DARWIN=y
else ifeq ($(OS),Windows_NT)
CONFIG_WINDOWS=y
else
CONFIG_LINUX=y
endif

ifdef CONFIG_DARWIN
LOADABLE_EXTENSION=dylib
LDFLAGS_SHARED=-undefined dynamic_lookup
endif

ifdef CONFIG_LINUX
LOADABLE_EXTENSION=so
LDFLAGS_SHARED=
endif

ifdef CONFIG_WINDOWS
LOADABLE_EXTENSION=dll
LDFLAGS_SHARED=
endif

# Compiler and flags
CC = gcc
CFLAGS = -I. -I../include -I../_deps/sqlite-src -I../_deps/Unity-2.5.2/src -I./src -g -O0 -std=gnu99 -fPIC -Wall -Wextra 
CFLAGS += $(EXTRA_CFLAGS)
LDFLAGS = -lm

# Directories
BUILD_DIR = ../build
OBJ_DIR = $(BUILD_DIR)/obj/src

# Source files - include all C files except problematic ones  
SRCS = $(filter-out cypher/cypher-sql.c, $(wildcard *.c) $(wildcard cypher/*.c))
# Add the fixed cypher SQL functions
SRCS += cypher/cypher-sql-fixed.c
SRCS += graph-vtab.c
SRCS += graph-memory.c
SRCS += graph-destructors.c
# Add graph-advanced.c to SRCS to ensure its object file is included in main libraries
SRCS += graph-advanced.c
SRCS += cypher/cypher-ast.c

OBJS = $(patsubst %.c,$(OBJ_DIR)/%.o,$(SRCS))
OBJS += ../build/obj/_deps/sqlite-src/sqlite3.o

# Static library for test utilities
TEST_UTIL_SRCS = graph-util.c graph-algo.c graph-advanced.c
TEST_UTIL_OBJS = $(patsubst %.c,$(OBJ_DIR)/%.o,$(TEST_UTIL_SRCS))

.PHONY: all clean

all: $(BUILD_DIR)/libgraph.$(LOADABLE_EXTENSION) $(BUILD_DIR)/libgraph_static.a $(BUILD_DIR)/libgraph_test_util.a

$(BUILD_DIR)/libgraph.$(LOADABLE_EXTENSION): $(OBJS)
	$(CC) -shared -o $@ $^ $(LDFLAGS) $(LDFLAGS_SHARED)

$(BUILD_DIR)/libgraph_static.a: $(OBJS)
	ar rcs $@ $^

$(BUILD_DIR)/libgraph_test_util.a: $(TEST_UTIL_OBJS)
	ar rcs $@ $^

$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: cypher/%.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TEST_UTIL_OBJS) $(BUILD_DIR)/libgraph.$(LOADABLE_EXTENSION) $(BUILD_DIR)/libgraph.so $(BUILD_DIR)/libgraph_static.a $(BUILD_DIR)/libgraph_test_util.a
