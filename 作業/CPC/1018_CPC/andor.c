#include<stdio.h>
int main()
{
  int n;
  scanf("%d", &n);
  if(n >= 10 && n < 20){
    printf("and ");
    if(n != 10){
      printf("%d\n", n);
    }
  }
  else if(n < 10 || n >= 20){
    printf("or ");
    if(n == 20){
      printf("%d\n", n);
    }
  }
}


