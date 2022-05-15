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

int find(int xs, int ys,int x, int y)
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
__declspec(dllexport) void controller(int &action, const size_t agent, const size_t num_agents, const size_t num_resources, const int* circleRadius,
                                      const int* xCoordinate, const int* yCoordinate, const int* xVelocity, const int* yVelocity) // the coordinates of  balls and resource centers are in turn placed in the array xCoordinate, and yCoordinate
{

    int minn = 4810500;
    int loc = 0;
    for(int i = 1; i <= 14; i++) //查所有球球的大小
    {
        if(circleRadius[i] < circleRadius[0])//當半徑比我小時
        {
            int ad = 0;// 利益值
            ad = (xCoordinate[i] - xCoordinate[0]) * (xCoordinate[i] - xCoordinate[0]) + (yCoordinate[i] - yCoordinate[0]) * (yCoordinate[i] - yCoordinate[0]) + (200 - circleRadius[i]) * (200 - circleRadius[i])*100;
            // 考慮距離，和半徑大小，但半徑的數值比距離小，所以乘100
            if(ad < minn)
            {
                minn = ad;
                loc = i;
            }
        }
    }
    action = find(xCoordinate[0], yCoordinate[0],xCoordinate[loc], yCoordinate[loc]);

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
            // attach to process
            // return FALSE to fail DLL load
            break;

        case DLL_PROCESS_DETACH:
            // detach from process
            break;

        case DLL_THREAD_ATTACH:
            // attach to thread
            break;

        case DLL_THREAD_DETACH:
            // detach from thread
            break;
    }
    return TRUE; // succesful
}
