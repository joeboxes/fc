# Makefile
# 
#CC=g++
#CFLAGS=-I. -Wall -Wformat
CC=gcc
CFLAGS= -Wall -Wformat  -Wno-format -I. -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/ 

default: main

all: main

main: main.o
	$(CC)  $(CFLAGS)   main.o  -o main

main.o: main.c
	$(CC)  $(CFLAGS)   -c main.c

clean:
	rm *.o main 