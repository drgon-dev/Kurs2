#include <stdio.h>

int hz() {
int A=0;
while(A < 10000000) {A += 10;
A -= 9;}
return 0;
}
int count() {
int C=0;
int CA=1;
int CB=2;
while(CB < 10000000) {C += CA;
C += CB;
CA += CB;
CA += C;
CB += CA;
CB += C;}
int F=0;
while(F < 100) {F += 1;
hz();}
return 0;
}
int main() {
int B=5;
int AB=64;
B += 500;
if(B > AB) {B -= 150;}
printf("%d\n", B);
printf("%d\n", AB);
count();
return 0;
}