// main.c
// g++ main.c -o main
// ./main

#include <stdio.h> // printf
#include <stdlib.h> // *alloc/free
#include <cstring> // strcpy

// type declarations
struct person {
	char name[16];
	int age;
};
typedef struct {
	char name[16];
	int age;
} human;

int main(int argc, char **argv) {
    // person 
	struct person richie;
	strcpy(richie.name,"Richie");
    richie.age = 27;
    printf("name: %s, age:%d \n",richie.name,richie.age);

    // human
    human john;
    strcpy(john.name,"John");
    john.age = 32;
    printf("name: %s, age:%d \n",john.name,john.age);
}
