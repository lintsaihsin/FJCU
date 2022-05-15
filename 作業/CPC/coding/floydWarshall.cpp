#include<bits/stdc++.h>
using namespace std;
int dp[1005][1005];
int main(int argc, char const *argv[])
{
    int n, m;
    cin >> n >> m;
    memset(dp, 0x3f, sizeof(dp));
    for(int i = 0; i <= n; i++){
        dp[i][i] = 0;
    }
    while(m--){
        int f, t, d;
        cin >> f >> t >> d;
        dp[f][t] = d;
        dp[t][f] = d;
    }
    for(int k = 1; k <= n; k++){
        for(int i = 1; i <= n; i++){
            for(int j = 1; j <= i; j++){
                dp[i][j] = dp[j][i] = min(dp[i][j], dp[i][k] + dp[k][j]);
            }
         }
    }
    // cout << "dp : " << endl;
    // for(int i = 1; i <= n; i++){
    //     for(int j = 1; j <= n; j++){
    //         cout << dp[i][j] << " ";
    //      }
    //      cout << endl;
    // }
    int t;
    cin >> t;
    while(t--){
        int x, y;
        cin >> x >> y;
        cout << dp[x][y] << endl;
    }
    return 0;
}