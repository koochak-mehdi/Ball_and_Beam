clear all, close all, clc
%% states variables definition
%  r:   ball's position     r_dot:  ball's velocity
%  a:   beam's angle        a_dot:  angular velocity
%% inizialize the parameters

syms m R g J Jb p0;

A = [0               1 0              0;
     0               0 -m*g/(Jb/R^2+m) 0;
     0               0 0              1;
     -m*g/(m*p0^2+J) 0 0              0];
 
A_hat = [0  1 0               0;
         0  0 -m*g/(Jb/R^2+m) 0;
         0  0 0               1;
         0  0 0               0];
 
B = [0;
     0;
     0;
     1/(m*p0^2+J)];
 
B_hat = [0;
         0;
         0;
         1];

C = [1 0 0 0];

x0 = [0 0 0 0];
%% initial system
%A = double(subs(A, [m R g J Jb p0], [.111 .015 9.8 19e-3 9.99e-6 0]));
%A = double(subs(A_hat, [m R g Jb], [.11 .015 9.8 9.99e-6]));
A = double(subs(A_hat, [m R g Jb], [.5 .015 9.8 9.99e-3]));

%B = double(subs(B, [m J p0], [.111 19e-3 0]));
B = double(B_hat);

sysFull = ss(A, B, C, 0);
sc = ctrb(sysFull);    % Steubarkeit
so = obsv(sysFull);    % Beobachtbarkeit
rank(sc);
rank(so);

%% controller
pole = [-3; -3; -3; -3];
k = acker(A, B, pole);

%% descrete system

Ts = .1;
sysDes = c2d(sysFull, Ts);
[Ad, Bd, Cd, Dd] = ssdata(sysDes);

pole_d = [.7; .7; .7; .7];
k_d = acker(Ad, Bd, pole_d);

Q = eye(4);
R = .5;
[k_lqr_d, ~, ~] = dlqr(Ad, Bd, Q, R);

%% oberver

pole_d_l = pole_d*.7;
l_d = acker(Ad', Cd', pole_d_l);
l_lqr_d = dlqr(Ad', Cd', Q*1.2, R);


