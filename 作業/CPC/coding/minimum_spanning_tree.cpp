#include<bits/stdc++.h>
using namespace std;
int n, m;
int path[100005];
int fg[100005];
int nd[100005];
int sum;
int ttl;
struct node
{
    // int f;
    int t;
    int dis;
};
struct compare {
    bool operator()(node const& nd1, node const& nd2)
    {
        return nd1.dis > nd2.dis;
    }
};
vector<node> v[100005];
priority_queue<node, vector<node>, compare> pq;
void dfs(int i){
    for(auto j:v[i]){
        if(!nd[j.t]){
            pq.push(node{j.t, j.dis});
        }         
    }
    node tmp;
    while(1){
        tmp = pq.top();
        if(nd[tmp.t]) pq.pop();
        else break;
        if(pq.empty()) break;
    }
    // cout << "in : " <<  tmp.t << " " << tmp.dis << endl;
    sum += tmp.dis;
    ttl++;
    if(ttl == n)return;
    nd[tmp.t] = 1;
    dfs(tmp.t);
}
int main(int argc, char const *argv[])
{
    cin >> n >> m;
    for(int i = 0 ; i < m ; i++){
        int x, y, d;
        cin >> x >> y >> d;
        v[x].push_back(node{y, d});
        v[y].push_back(node{x, d});
    }
    sum = 0;
    ttl = 1;
    nd[1] = 1;
    dfs(1);
    // for(int i = 1; i <= n; i++){
    //     cout << i << " -> " << endl;
    //     for(auto j:v[i]){
    //         cout << j.t << " : " << j.dis << endl;
    //     }
    // }
    cout << sum << endl;
    return 0;
}