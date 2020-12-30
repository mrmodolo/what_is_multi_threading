all: ./build/hello ./build/matrix_multiplication ./build/server

./build/hello: ./src/hello_world.c
	gcc -o ./build/hello ./src/hello_world.c -lpthread

./build/matrix_multiplication:
	gcc -o ./build/matrix_multiplication ./src/simple_multi-threaded_matrix_multiplication.c -lpthread

./build/server:
	gcc -o ./build/server ./src/simple_server.c -lpthread 

