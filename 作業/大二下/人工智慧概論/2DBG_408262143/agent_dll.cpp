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

int run(int action) //���Ϥ�V�]
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

int find(int xs, int ys,int x, int y) //�e�i��V
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
int xd = 0, yd = 0; // agent��X�BY���O�����ʶZ��
int lastx = 0, lasty = 0; //�O���e�@��agent��X�BY��
__declspec(dllexport) void controller(int &action, const size_t agent, const size_t num_agents, const size_t num_resources, const int* circleRadius,
                                      const int* xCoordinate, const int* yCoordinate, const int* xVelocity, const int* yVelocity) // the coordinates of  balls and resource centers are in turn placed in the array xCoordinate, and yCoordinate
{
    freopen("out.out", "a+" , stdout);
    int minn = 4810500;
    int locmin = 0; //�����ĴX���y���Q�q�ȳ̤j��
    int tmpbig = 0; //�����ĴX���y����agent�p���̤j��
    int big = 0;//��agent�p�����̤j��
    int ttl = 0;//��agent�p���Ȫ��`�M
    int am = 0;//��agent�p�����y��
    int flag = 0;//�����O�_������ɩιJ���ۤv�j���y
    int bai;
    xd = xCoordinate[0] - lastx; // agent X�����ʶZ��
    yd = yCoordinate[0] - lasty; // agent Y�����ʶZ��

    int wxd = xd;
    int wyd = yd;
    xd = xd * (abs(xd) + 1) /2;
    yd = yd * (abs(yd) + 1) /2;
    wxd += xd;
    wyd += yd;
    int xdist;//��yx�b�Z��+agent X�N���Z������
    int ydist;//��yy�b�Z��+agent Y�N���Z������
    for(int i = 0; i <= 14; i++) //�d�Ҧ��y�y���j�p
    {
        xdist = (xCoordinate[i] - xCoordinate[0] );
        ydist = (yCoordinate[i] - yCoordinate[0] );
        if(circleRadius[i] > circleRadius[0] && i < 10) // ��b�|��agent�j�A�ì��²y��
        {
            if((wxd *xdist > 0 && abs(wxd) +1 > abs(xdist)  ) && (wyd *ydist > 0 && abs(wyd) +1 > abs(ydist) )) //�j�y�bagent����
            {
                action = find(xCoordinate[0], yCoordinate[0],xCoordinate[i], yCoordinate[i]);
                //���ؼвy����V
                action = run(action); // ���Ϥ�V�]
                flag = 2; //���j�y�b����
                bai = i;
                cout << "xd : " << xd <<" xdist : " << xdist <<endl;
                cout << "yd : " << yd <<" ydist : " << ydist <<endl;
            }
        }
        else if(circleRadius[i] < circleRadius[0] || i >= 10 )//��b�|��agent�p�A�ά��²y��
        {
            ttl += circleRadius[i]; // �Ҧ���agent�p���Ȫ��`�M
            am++; //�Ҧ���agent�p���Ȫ��Ӽ�
            if(circleRadius[i] > big)
            {
                big = circleRadius[i];//�Ҧ���agent�p���̤j����
                tmpbig = i;//�Ҧ���agent�p���̤j���Ȫ��y
            }
            int ad = 0;// �Q�q��
            xdist *= xdist;
            ydist *= ydist;
            if( circleRadius[i] > 0) ad = xdist + ydist + ((200 - circleRadius[i]) * (200 - circleRadius[i])*10);

            // �Ҽ{�Z���A�M�b�|�j�p�A���b�|���ƭȤ�Z���p�A�ҥH��10
            if(ad < minn && ad != 0) //ad��0�A�N��ؼвy�b�|��0�A�]�����p�J�A�ç�X�̭ȱo�l��target
            {
                minn = ad;
                locmin = i;
            }
        }
    }
    ttl /= am; //��X����
    if(big > ( ttl + 20)  )//�p�G��agent�p�����̤j�y�񥭧��h20�A�htarget�������y
    {
        locmin = tmpbig;
    }

    //�Y����ɤӪ�A�h���Ϥ�V����
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
    radiusdist = circleRadius[0] + circleRadius[locmin]; //agent�P�ؼвy���b�|�Z��
    radiusdist *= (-1);
    if(flag == 0) //�Y�S�I��j�y�A�ΨS�I��ɡA�h�µ�target����
    {
        action = find(xCoordinate[0], yCoordinate[0],xCoordinate[locmin], yCoordinate[locmin]);
        //���Ϥ�V���O�A�Ӫ���ɽ�
        if((abs(xCoordinate[0] - xCoordinate[locmin]) + circleRadius[locmin] < xd )&& (abs(yCoordinate[0] - yCoordinate[locmin]) + circleRadius[locmin] < yd ))
        {
            action = run(action); // ���Ϥ�V�]
        }
        else if((abs(xCoordinate[0] - xCoordinate[locmin]) + circleRadius[locmin] < xd )) //���ܥ��k��V
        {
            if(action == 3) action = 4;
            else if(action == 4) action = 3;
            else if(action == 5) action = 6;
            else if(action == 6) action = 5;
            else if(action == 7) action = 8;
            else if(action == 8) action = 7;
        }
        else if((abs(yCoordinate[0] - yCoordinate[locmin]) + circleRadius[locmin] < yd ))//���ܤW�U��V
        {
            if(action == 1) action = 2;
            else if(action == 2) action = 1;
            else if(action == 5) action = 7;
            else if(action == 7) action = 5;
            else if(action == 6) action = 8;
            else if(action == 8) action = 6;
        }
    }

    //�N��e��m�ǤJlastx�Blasty
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
