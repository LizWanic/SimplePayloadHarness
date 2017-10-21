// Elizabeth Wanic
// 10 April 2017
// CS4678 - Assignment 1
//
// Command line for gcc :
//    gcc -z execstack -o assn1_harness -m32 assn1_harness.c  
//
//

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>


void main(int argc, const char ** argv) {

	char buf[1024];
	int fd = open(argv[1], O_RDONLY);
	read(fd, buf, sizeof(buf));
	void (*func)() = buf;
	(*func)();

}