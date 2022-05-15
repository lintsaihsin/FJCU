#include <stdio.h>

int main()
{
  int n, m;
  scanf("%d %d", &n, &m);
  if(n % 2 == 1)
    n++;
  for(int i = n; i <= m; i+= 2){
    printf("%d ", i);
  }
}

