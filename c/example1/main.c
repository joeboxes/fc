// main.c
// g++ main.c -o main
// ./main

#include <stdio.h> // printf
#include <stdlib.h> // *alloc/free

int main(int argc, char **argv) {

    int i;
    int *j;
    j = &i;
    fprintf(stdout, "example1: \n");
    printf("A) i: %d, j: %d \n",i,*j); // A) i: 7, j: 1
    i = 5;
    printf("B) i: %d, j: %d \n",i,*j); // B) i: 5, j: 5
    *j = 9;
    printf("C) i: %d, j: %d \n",i,*j); // C) i: 9, j: 9

	return 0;
}

