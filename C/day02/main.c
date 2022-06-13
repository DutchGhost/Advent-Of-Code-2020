#include <stdio.h>
#include <stdlib.h>

const char * INPUT_FILE = "../../Inputs/day02.txt";

int main() {
	FILE * f = fopen(INPUT_FILE, "r");
	if(!f) {
		printf("File %s could not be opened", INPUT_FILE);
		exit(1);
	}

    unsigned char line[255] = {0};
    int valids_p1 = 0;
    int valids_p2 = 0;

    while(fgets((char * )&line, 50, f)) {
        char buff[4] = {0};
        unsigned char * ptr = (unsigned char *) &line;

        // [4]-15 b: fctbwzqnwbnvqbqlb
        for(int i = 0; ((unsigned char) (*ptr - '0')) < 10; i++) {
            buff[i] = *ptr++;
        }
        int min = atoi((char *) buff);
        // 4[-]15 b: fctbwzqnwbnvqbqlb
        ptr++;

        // 4-[15] b: fctbwzqnwbnvqbqlb
        for(int i = 0; ((unsigned char) (*ptr - '0')) < 10; i++) {
            buff[i] = *ptr++;
        }
        int max = atoi((char *) buff);

        // 4-15[ ]b: fctbwzqnwbnvqbqlb
        ptr++;
        // 4-15 [b]: fctbwzqnwbnvqbqlb
        char letter = *ptr;

        //4-15 b[: ]fctbwzqnwbnvqbqlb
        ptr += 2;

        char first = ptr[min];
        char second = ptr[max];

        if((first == letter || second == letter) && first != second) valids_p2 += 1;

        int count = 0;
        while(*ptr) {
            if(*ptr == letter) count += 1;
            ptr++;
        }

        if(count >= min && count <= max) valids_p1 += 1;
    }

    printf("p1 = %d p2 = %d\n", valids_p1, valids_p2);
}