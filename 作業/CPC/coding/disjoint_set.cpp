#include<bits/stdc++.h>
using namespace std;
int n, m;
int path[100005];
int fg[100005];
int nd[100005];
vector<int> v[100005];
void dfs(int i){
    for(auto j:v[i]){
        if(path[j] <= path[i])
            continue;
        nd[j] = 1;
        path[j] = path[i];
        dfs(j);           
    }
    return;
}
int main(int argc, char const *argv[])
{
    cin >> n >> m;
    for(int i = 1; i <= n; i++){
        path[i] = i;
    }
    for(int i = 1; i <= m; i++){
        int a, b;
        cin >> a >> b;
        v[a].push_back(b);
        v[b].push_back(a);
    }
    int cnt = 0;
    for(int i = 1; i <= n; i++){
        if(nd[i] == 0){
            cnt++;
            dfs(i);
        }
        // for(auto j : v[i]){
        //     path[j] = min(path[j], path[i]);
        // }
    }
    // for(int i = 1; i <= n; i++){
    //     cout << i << " : " << path[i] << endl;
    //     // if(fg[path[i]] == 0){
    //     //     cnt++;
    //     //     fg[path[i]] = 1;
    //     // }
    // }
    cout << cnt << endl;
    
    return 0;
}