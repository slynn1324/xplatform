#include "functions.h"

int add(int a, int b){
	return a+b;
}

char* getMessage(){
	return "hello, world!";
}

int main(){
	printf("add(2,3) => %d\n", add(2,3));
	printf("add(3,5) => %d\n", add(3,5));
	printf("getMessage() => %s\n", getMessage());
	return 0;
}