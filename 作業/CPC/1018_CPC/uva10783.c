#include <stdio.h>

int main()
{
  int t;
  scanf("%d", &t);
  int cs;
  for(cs = 1; cs <= t; cs++){
    int a, b;
    scanf("%d%d", &a, &b);
    int ttl = 0;
    int i;
    for(i = a; i <= b; i++){
      if(i % 2 != 0){
        ttl += i;
      }
    }
    printf("Case %d: %d\n", cs, ttl);
  }
  return 0;
}
