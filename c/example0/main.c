// main.c
// g++ main.c -o main
// ./main hello world

#include <stdio.h> // printf
#include <stdlib.h> // *alloc/free

int main(int argc, char **argv) {
    // argc is the argument count
    // argv are the argument values - a list of cstrings
    // first argv is command issued (or filename)
    int i;
    for(i=0; i<argc; ++i){
        printf("arg %d: %s \n",i,argv[i]);
    }
    return EXIT_SUCCESS; // EXIT_SUCCESS = 0 = success
    // EXIT_FAILURE = 1 = (nonzero) = fail
}
