#include <stdio.h>
#include <stdlib.h>

const char * INPUT_FILE = "../../Inputs/day01.txt";
const int MAGIC = 2020;

int main() {
	FILE * f = fopen(INPUT_FILE, "r");
	if(!f) {
		printf("File %s could not be opened", INPUT_FILE);
		exit(1);
	}
	
	char buff[255] = {0};
	int cache[1000] = {0};
	int idx = 0;
	
	int p1 = 0;
	int p2 = 0;

	while(fgets((char * )&buff, 50, f)) {
		int parsed = atoi((char *) &buff);
		int key = MAGIC - parsed;

		for(int i = idx; i != 0; i--) {
			if(!p1) {
				if(cache[i] == key) {
					p1 = key * parsed;
				}
			} else if(!p2) {
				for(int j = i - 1; j > 0; j--) {
					int key2 = MAGIC - cache[i] - parsed;
					if(cache[j] == key2) p2 = cache[i] * key2 * parsed;
				}
			} else {
				printf("p1 = %d, p2 = %d\n", p1, p2);
				exit(0);
			}
		}

		cache[idx] = parsed;
		idx += 1;
	}
}
