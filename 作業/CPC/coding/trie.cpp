//UVA 11488
//字典樹

#include <bits/stdc++.h>
using namespace std;
int ans;
int idx = 0;



struct tree
{
  int nxt[2];
  int cnt;
  int id;
}node[100005];

void init(int a){
  node[a].cnt = node[a].id = 0;
  memset(node[a].nxt, 0 , sizeof(node[a].nxt));
}

void insert(string str){
  int cur = 0;
  for(auto i : str){
    int pre = cur;
    if(node[cur].nxt[i - '0'] == 0){
      idx++;
      init(idx);
      node[cur].nxt[i - '0'] = idx;
      cur = idx;
    }
    else{
      cur = node[cur].nxt[i - '0'];
    }
    node[cur].id = node[pre].id + 1;
    node[cur].cnt++;
    ans = max(node[cur].cnt * node[cur].id , ans);
  }
  
}

int main()
{
  int t;
  cin >> t;
  while(t--){
    int n;
    ans = 0;
    idx = 0;
    cin >> n;
    init(0);
    while(n--){
      string str;
      cin >> str;
      insert(str);
    }
    cout << ans << endl;
  }
  return 0;
}

