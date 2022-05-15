#include <stdio.h>
int main()
{
  int i, j;
  while(~scanf("%d %d\n", &i, &j)){
    printf("%d %d ", i, j);
    if(i > j){
      int tmp;
      tmp = i;
      i = j;
      j = tmp; //維持i <= j
    }
    int max = 0;
    int n;
    for(n = i; n <= j; n++){
      int cnt = 0;
      int num = n;
      while(num != 1){
        if(num % 2 == 1){ // n為奇數
          cnt++;
          num = 3*num + 1;
        } 
        else{ // n為偶數
          cnt++;
          num /= 2;
        }
      }
      cnt++; // 補上沒算到的'1'
      if(max < cnt){
        max = cnt; // 更新最大數列長度
      }
    }
    printf("%d\n", max);
  }
}








