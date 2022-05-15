#include <stdio.h>

int main()
{
  int n;
  scanf("%d", &n);
  for(int i = 0; i <= 100; i+= 2){
    int fg = 1;
    for(int j = 2; j < i; j++){
      if(i % j == 0){
        fg = 0;
      }
    }
    if(fg == 1){
      printf("%d\n", i);
    }
  }
}






