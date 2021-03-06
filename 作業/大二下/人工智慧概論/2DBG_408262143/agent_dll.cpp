#include "agent_dll.h"
#include <bits/stdc++.h>
using namespace std;
const size_t NUM_ACTIONS = 9;
enum actions { NOOP = 0, UP, DOWN, LEFT, RIGHT, UP_LEFT, UP_RIGHT, DOWN_LEFT, DOWN_RIGHT };
int xCoordinate[20], yCoordinate[20];
#ifdef __cplusplus
extern "C"
{
#endif

int run(int action) //往反方向跑
{
    if(action == 1) action = 2;
    else if(action == 2) action = 1;
    else if(action == 3) action = 4;
    else if(action == 4) action = 3;
    else if(action == 5) action = 8;
    else if(action == 6) action = 7;
    else if(action == 7) action = 6;
    else if(action == 8) action = 5;
    return action;
}

int find(int xs, int ys,int x, int y) //前進方向
{
    int action;
    if(xs > x && ys > y) action = UP_LEFT;
    else if(xs> x && ys < y) action = DOWN_LEFT;
    else if(xs< x && ys < y) action = DOWN_RIGHT;
    else if(xs< x && ys > y) action = UP_RIGHT;
    else if(xs== x && ys < y) action = DOWN;
    else if(xs== x && ys > y) action = UP;
    else if(xs> x && ys == y) action = LEFT;
    else if(xs< x && ys == y) action = RIGHT;
    return action;
}
string str[10] = { "NOOP" ,"UP", "DOWN", "LEFT", "RIGHT", "UP_LEFT", "UP_RIGHT", "DOWN_LEFT", "DOWN_RIGHT" };
int xd = 0, yd = 0; // agent的X、Y分別的移動距離
int lastx = 0, lasty = 0; //記錄前一個agent的X、Y值
__declspec(dllexport) void controller(int &action, const size_t agent, const size_t num_agents, const size_t num_resources, const int* circleRadius,
                                      const int* xCoordinate, const int* yCoordinate, const int* xVelocity, const int* yVelocity) // the coordinates of  balls and resource centers are in turn placed in the array xCoordinate, and yCoordinate
{
    freopen("out.out", "a+" , stdout);
    int minn = 4810500;
    int locmin = 0; //紀錄第幾顆球為利益值最大的
    int tmpbig = 0; //紀錄第幾顆球為比agent小中最大的
    int big = 0;//比agent小中的最大值
    int ttl = 0;//比agent小中值的總和
    int am = 0;//比agent小中的球數
    int flag = 0;//紀錄是否撞到邊界或遇到比自己大的球
    int bai;
    xd = xCoordinate[0] - lastx; // agent X的移動距離
    yd = yCoordinate[0] - lasty; // agent Y的移動距離

    int wxd = xd;
    int wyd = yd;
    xd = xd * (abs(xd) + 1) /2;
    yd = yd * (abs(yd) + 1) /2;
    wxd += xd;
    wyd += yd;
    int xdist;//兩球x軸距離+agent X將走距離平方
    int ydist;//兩球y軸距離+agent Y將走距離平方
    for(int i = 0; i <= 14; i++) //查所有球球的大小
    {
        xdist = (xCoordinate[i] - xCoordinate[0] );
        ydist = (yCoordinate[i] - yCoordinate[0] );
        if(circleRadius[i] > circleRadius[0] && i < 10) // 當半徑比agent大，並為黑球時
        {
            if((wxd *xdist > 0 && abs(wxd) +1 > abs(xdist)  ) && (wyd *ydist > 0 && abs(wyd) +1 > abs(ydist) )) //大球在agent附近
            {
                action = find(xCoordinate[0], yCoordinate[0],xCoordinate[i], yCoordinate[i]);
                //找到目標球的方向
                action = run(action); // 往反方向跑
                flag = 2; //有大球在附近
                bai = i;
                cout << "xd : " << xd <<" xdist : " << xdist <<endl;
                cout << "yd : " << yd <<" ydist : " << ydist <<endl;
            }
        }
        else if(circleRadius[i] < circleRadius[0] || i >= 10 )//當半徑比agent小，或為黑球時
        {
            ttl += circleRadius[i]; // 所有比agent小的值的總和
            am++; //所有比agent小的值的個數
            if(circleRadius[i] > big)
            {
                big = circleRadius[i];//所有比agent小中最大的值
                tmpbig = i;//所有比agent小中最大的值的球
            }
            int ad = 0;// 利益值
            xdist *= xdist;
            ydist *= ydist;
            if( circleRadius[i] > 0) ad = xdist + ydist + ((200 - circleRadius[i]) * (200 - circleRadius[i])*10);

            // 考慮距離，和半徑大小，但半徑的數值比距離小，所以乘10
            if(ad < minn && ad != 0) //ad為0，代表目標球半徑為0，因此不計入，並找出最值得追的target
            {
                minn = ad;
                locmin = i;
            }
        }
    }
    ttl /= am; //算出平均
    if(big > ( ttl + 20)  )//如果比agent小中的最大球比平均多20，則target換成此球
    {
        locmin = tmpbig;
    }

    //若離邊界太近，則往反方向移動
    if((xCoordinate[0] - circleRadius[0] + wxd) < 10 && (yCoordinate[0] - circleRadius[0] + wyd)< 5 && flag != 2)
    {
        action = 8;
        flag = 1;
    }
    else if((xCoordinate[0] + circleRadius[0] + wxd)> 1590  && (yCoordinate[0] - circleRadius[0] + wyd)< 5 && flag != 2)
    {
        action = 7;
        flag = 1;
    }
    else if((xCoordinate[0] - circleRadius[0] + wxd) < 10 && (yCoordinate[0] + circleRadius[0] + wyd) > 895 && flag != 2)
    {
         action = 6;
        flag = 1;
    }
    else if((xCoordinate[0] + circleRadius[0] + wxd)> 1590 && (yCoordinate[0] + circleRadius[0] + wyd) > 895 && flag != 2)
    {
         action = 5;
        flag = 1;
    }
    else if((xCoordinate[0] - circleRadius[0] + wxd) < 10 && flag != 2)
    {
        action = 4;
        flag = 1;
    }
    else if((xCoordinate[0] + circleRadius[0]+ wxd)> 1590 && flag != 2)
    {
        action = 3;
        flag = 1;
    }
    else if((yCoordinate[0] - circleRadius[0] + wyd)< 5 && flag != 2)
    {
        action = 2;
        flag = 1;
    }
    else if((yCoordinate[0] + circleRadius[0]+ wyd) > 895 && flag != 2)
    {
        action = 1;
        flag = 1;
    }

    int radiusdist;
    radiusdist = circleRadius[0] + circleRadius[locmin]; //agent與目標球的半徑距離
    radiusdist *= (-1);
    if(flag == 0) //若沒碰到大球，或沒碰邊界，則朝著target移動
    {
        action = find(xCoordinate[0], yCoordinate[0],xCoordinate[locmin], yCoordinate[locmin]);
        //給反方向的力，來阻止暴衝
        if((abs(xCoordinate[0] - xCoordinate[locmin]) + circleRadius[locmin] < xd )&& (abs(yCoordinate[0] - yCoordinate[locmin]) + circleRadius[locmin] < yd ))
        {
            action = run(action); // 往反方向跑
        }
        else if((abs(xCoordinate[0] - xCoordinate[locmin]) + circleRadius[locmin] < xd )) //改變左右方向
        {
            if(action == 3) action = 4;
            else if(action == 4) action = 3;
            else if(action == 5) action = 6;
            else if(action == 6) action = 5;
            else if(action == 7) action = 8;
            else if(action == 8) action = 7;
        }
        else if((abs(yCoordinate[0] - yCoordinate[locmin]) + circleRadius[locmin] < yd ))//改變上下方向
        {
            if(action == 1) action = 2;
            else if(action == 2) action = 1;
            else if(action == 5) action = 7;
            else if(action == 7) action = 5;
            else if(action == 6) action = 8;
            else if(action == 8) action = 6;
        }
    }

    //將當前位置傳入lastx、lasty
    lastx = xCoordinate[0];
    lasty = yCoordinate[0];
    cout << "flag : " << flag << endl;
    if(flag == 0) cout << locmin << " " << circleRadius[locmin] << endl;
    else if(flag == 2) cout << "bai : " << bai <<" " << circleRadius[bai] << endl;
    cout << "my r: " << circleRadius[0] <<endl;
    cout << "action : "<< action << " " << str[action] << endl <<endl;
    return ;
}

#ifdef __cplusplus
}
#endif

extern "C" DLL_EXPORT BOOL APIENTRY DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved)
{
    switch (fdwReason)
    {
        case DLL_PROCESS_ATTACH:
            // attach to process\

            break;
    }
    return TRUE; // succesful
}
