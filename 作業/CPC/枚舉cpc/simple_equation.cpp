#include<bits/stdc++.h>
using namespace std;

int main(){
    int a,b,c,i,n,p,sad;
    long long int x,y,z;
    while(cin >> n){
	    for(i=1;i<=n;i++){
	     	cin >> a >> b >> c;
	     	p=0;
	    	for(x=-100;3*x<a;x++){
    			for(y=x+1;x+2*y<a;y++){
   					z=a-x-y;
	       
        			if(x*y*z==b && x*x+y*y+z*z==c && y!=z){
        				p=1;
        				break;
	   				} 
    			}
   				if(p)
     				break;
   			} 
		   	if(p)
		    	printf("%d %d %d\n",x,y,z);
		   	else
		    	printf("No solution.\n");
		 }
	}
    return 0;
}