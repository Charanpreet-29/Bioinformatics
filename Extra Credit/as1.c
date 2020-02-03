#include<stdio.h>
#include<stdlib.h> 
#include<errno.h> 
#include<string.h> 
#include<sys/types.h>
int main() {
	char nameplate[300000]; 
        int val; 
        printf("Enter Name plate number \n"); 
         scanf("%s", &nameplate); 
       printf("\n divide integer ");
       scanf("%d",&val);
        printf("the licence number is	%s \n", nameplate);
}
