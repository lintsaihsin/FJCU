#include <bits/stdc++.h>
using namespace std;

int prime[10000050] = {0};

int main(int argc, char const *argv[])
{
	prime[0] = prime[1] = 1;
	for (int i = 2; i < 10000000; ++i)
	{
		if(prime[i] == 0)
		{
			for (int j = i+i; j < 10000000; j += i)
			{
				prime[j] = 1;
			}
		}
	}

	
	int n;
	cin >> n;
	while(n--)
	{
		string str;
		cin >> str;
		set<int> s;
		s.clear();
		sort(str.begin(), str.end());
		do
		{
			int ans = 0;
			for (int i = 0; i < str.size(); ++i)
			{
				ans += (str[i] - '0');
				if(!prime[ans]) s.insert(ans);
				ans *= 10;
			}
		}
		while(next_permutation(str.begin(), str.end()));
		cout << s.size() << '\n';
	}
	return 0;
}