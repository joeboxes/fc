// main.c
// g++ main.c -o main
// ./main

#include <stdio.h> // printf
#include <stdlib.h> // *alloc/free
#include <cstring> // strcpy
#include <cmath> // pi

// type declarations
typedef struct {
	char firstName[32];
    char lastName[32];
	int age;
} person;

// example of untyped (also no objects) bliss
int main(int argc, char **argv) {
    // catch all pointer
    void *pointer;

    int i = 8;
    float f = 2.414;
    double d = M_PI;

    // integer
    pointer = &i;
    printf(" i: %d \n", i );
    printf("i*: %d \n", *((int*)pointer) );
    *(int*)pointer = 123;
    i = *((int*)pointer); // assignment
    printf(" i: %d \n", i );
    printf("i*: %d \n", *((int*)pointer) );
    printf("\n");

    // float
    pointer = &f;
    printf(" f: %f \n", f );
    printf("f*: %f \n", *((float*)pointer) );
    *(float*)pointer = 1.234;
    f = *(float*)pointer; // assignment
    printf(" f: %f \n", f );
    printf("f*: %f \n", *((float*)pointer) );
    printf("\n");

    // double
    pointer = &d;
    printf(" d: %.10lf \n", d );
    printf("d*: %.10lf \n", *((double*)pointer) );
    *(double*)pointer = 9.87654321;
    d = *(double*)pointer; // assignment
    printf(" d: %.10lf \n", d );
    printf("d*: %.10lf \n", *((double*)pointer) );
    printf("\n");

    // struct
    person p;
	strcpy(p.firstName,"Richie");
    strcpy(p.lastName,"Zirbes");
    p.age = 27;
    printf(" p: %s %s is %d \n", p.firstName, p.lastName, p.age);
    pointer = &p;
    strcpy( (*((person*)pointer)).firstName, "Billy");
    strcpy( (*((person*)pointer)).lastName, "Bob");
    (*((person*)pointer)).age = 20;
    printf(" p: %s %s is %d \n", p.firstName, p.lastName, p.age);
    printf("\n");

    return 0;
}
