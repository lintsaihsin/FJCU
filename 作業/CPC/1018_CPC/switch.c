#include <stdio.h>

int main()
{
  int grade;
  scanf("%d", &grade);
  switch(grade)
  {
    case 10 :
        printf("1. You got 10 points\n" );
        break;
    case 20 :case 30 :
        printf("2. You got 20 or 30 points\n" );
        break;
    case 40 :
        printf("3. You got 40 points\n" );
        break;
    case 50 :
        printf("4. You got 50 points\n" );
        break;
    default :
        printf("5. You got %d points\n", grade );
  }
}

