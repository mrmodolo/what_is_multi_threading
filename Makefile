CC = clang
CFLAGS = -ggdb -Wall -Wextra -pthread
LDFLAGS = -lpthread
BUILD_DIR := ./build
SRC_DIR := ./src

all: $(BUILD_DIR)/hello $(BUILD_DIR)/matrix_multiplication $(BUILD_DIR)/server $(BUILD_DIR)/loop

$(BUILD_DIR)/hello: $(SRC_DIR)/hello_world.c
	-mkdir -p $(dir $@)
	$(CC) $< -o $@ $(CFLAGS) $(LDFLAGS)

$(BUILD_DIR)/matrix_multiplication: $(SRC_DIR)/simple_multi-threaded_matrix_multiplication.c
	-mkdir -p $(dir $@)
	$(CC) $< -o $@ $(CFLAGS) $(LDFLAGS)

$(BUILD_DIR)/server: $(SRC_DIR)/simple_server.c
	-mkdir -p $(dir $@)
	$(CC) $< -o $@ $(CFLAGS) $(LDFLAGS)

$(BUILD_DIR)/loop: $(SRC_DIR)/loop.c
	-mkdir -p $(dir $@)
	$(CC) $< -o $@ $(CFLAGS) $(LDFLAGS)

hello:
	valgrind --tool=memcheck --leak-check=yes --leak-check=full build/hello

loop:
	valgrind --tool=memcheck --leak-check=yes --leak-check=full build/loop

server:
	valgrind --tool=memcheck --leak-check=yes --leak-check=full build/server

matrix_multiplication:
	valgrind --tool=memcheck --leak-check=yes --leak-check=full build/matrix_multiplication

.PHONY: clean
clean:
	-rm -r $(BUILD_DIR)

