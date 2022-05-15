#include<bits/stdc++.h>
using namespace std;

int main()
{
  int t;
  cin >> t;
  string hold;
  getline(cin, hold);
  while(t--){
    string str;
    int tmp = 1;
    getline(cin, str);
    stack<char> st;
    int i;
    for(i = 0; i < str.size(); i++){
      if(str[i] == '(' || str[i] == '['){
        st.push(str[i]);
      }
      else if(!st.empty() && str[i] == ')' && st.top() == '('){
        st.pop();
      }
      else if(!st.empty() && str[i] == ']' && st.top() == '['){
        st.pop();
      }
      else break;
    }
    if(!st.empty() || i != str.size()) cout << "No" << endl;
    else cout << "Yes" << endl;
  }
}
