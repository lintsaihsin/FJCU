#include<bits/stdc++.h>
using namespace std;

int main()
{
  string str1, str2;
  while(cin >> str1 >> str2){
    int a1[30] = {0};
    int a2[30] = {0};
    for(int i = 0; i < str1.size(); i++){
      a1[str1[i] - 'A']++;
      a2[str2[i] - 'A']++;
    }
    priority_queue <int> pq1, pq2;
    for(int i = 0; i < 26; i++){
      if(a1[i] > 0) 
        pq1.push(a1[i]);
      if(a2[i] > 0) 
        pq2.push(a2[i]);
    }
    int tmp = 0;
    while(!pq1.empty() && !pq2.empty()){
      if(pq1.top() == pq2.top()){
        pq1.pop();
        pq2.pop();
      }
      else{
        break;
      }
    }
    if(!pq1.empty() || !pq2.empty()) cout << "NO" << endl;
    else cout << "YES" << endl;
  }
  return 0;
}
