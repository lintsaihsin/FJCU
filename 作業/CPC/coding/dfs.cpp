#include<bits/stdc++.h>
using namespace std;
int n, m;
int path[105];
vector<int> v[105];
int maxx = 0;
void dfs(int i){
    for(auto j:v[i]){
        if(path[j] <= path[i]+1)
            continue;
        path[j] = path[i]+1;
        dfs(j);           
    }
    return;
}
int main(int argc, char const *argv[])
{
    cin >> n >> m;
    for(int i = 1; i <= n; i++){
        path[i] = INT_MAX;
    }
    path[1] = 0;
    for(int i = 1; i <= m; i++){
        int a, b;
        cin >> a >> b;
        v[a].push_back(b);
        v[b].push_back(a);
    }
    dfs(1);
    for(int i = 1; i <= n; i++){
        maxx = max(maxx, path[i]);
    }
    cout << maxx << endl;
    
    return 0;
}