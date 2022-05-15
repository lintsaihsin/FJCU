#include<bits/stdc++.h>
using namespace std;

int main(int argc, char const *argv[])
{
    int n, m;
    cin >> n >> m;
    vector<int> v[15];
    while(m--){
        int a, b;
        cin >> a >> b;
        v[a].push_back(b);
        v[b].push_back(a);
    }
    for(int i = 1; i <= n; i++){
        cout << i << ":";
        sort(v[i].begin(), v[i].end());
        for(auto j:v[i]){
            cout << " " <<  j ;
        }
        cout << endl;
    }
    return 0;
}