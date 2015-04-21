// main.c
// gcc -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/  main.c -o main
// g++ main.c -o main
// 

#include <stdio.h> // printf
#include <stdlib.h> // *alloc/free

int main(int argc, char **argv) {
	int i;
	printf("MAIN\n");
	// show input arguments to program
	for (i=0; i<argc; ++i){
		printf("argv[%d]: %s \n",i,argv[i]);
	}

	// show addressing
	int variable; // integer
	int *pointer; // pointer to an integer
	pointer = &variable; // point to same location
	printf("\nCHECK A:\n");
	printf("variable address: %p \n", &variable); // 0xX...X
	printf("variable value: %d \n", variable); // 0
	printf("pointer address: %p \n", &pointer); // 0xX...X
	printf("pointer value: %p (%ld == %lx) \n", pointer,pointer,pointer); // 0xX...X
	printf("pointer reference value: %d \n", *pointer); // 0

	variable = 5;
	
	printf("\nCHECK B:\n");
	printf("variable address: %p \n", &variable); // 0xX...X
	printf("variable value: %d \n", variable); // 5
	printf("pointer address: %p \n", &pointer); // 0xX...X
	printf("pointer value: %p (%ld == %lx) \n", pointer,pointer,pointer); // 0xX...X
	printf("pointer reference value: %d \n", *pointer); // 5
	
	*pointer = 9;

	printf("\nCHECK C:\n");
	printf("variable address: %p \n", &variable); // 0xX...X
	printf("variable value: %d \n", variable); // 9
	printf("pointer address: %p \n", &pointer); // 0xX...X
	printf("pointer value: %p (%ld == %lx) \n", pointer,pointer,pointer); // 0xX...X
	printf("pointer reference value: %d \n", *pointer); // 9


	// indexing
	printf("\narray indexing:\n");
	int list[] = {1,2,3,4};
	int len = 5; // should be 4
	for(i=0;i<len;++i) {
		pointer = &list[i];
		printf("(%d) [%p] = %d\n", i, pointer, *pointer);
	}
	printf("^ accessing values post array end ^\n");
	printf("...\n");

	// memory management - int
	printf("\n dynamic int array\n");
	pointer = NULL;
	len = 10;
	pointer = (int*) malloc( sizeof(int)*len ); // (memory allocation)  vs  calloc (clear-allocation)
	for(i=0;i<len;++i) {
		printf("pointer[%d] = [%p] = %d\n", i, &pointer[i], pointer[i]);
	}
	free(pointer);
	pointer = NULL;

	// memory management - double
	printf("\n dynamic double array\n");
	double *pointerDouble = NULL;
	len = 10;
	pointerDouble = (double*) malloc( sizeof(double)*len ); // (memory allocation)  vs  calloc (clear-allocation)
	for(i=0;i<len;++i) {
		printf("pointer[%d] = [%p] = %lf\n", i, &pointerDouble[i], pointerDouble[i]);
	}
	free(pointerDouble);
	pointer = NULL;

	printf("...\n");

	// success
	return 0;
}

/*
%d = integer
%p = pointer
%ld = long integer
%x = hexidecimal foramt
%lx = long hexidecimal format
*/
