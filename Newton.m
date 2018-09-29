function [ endpoint, flag ] = Newton(tau,k,x0)
%NEWTON Implementation of Newton's Method to find zeros of F(x)=phi^tau(x)+k-x
%   These are flow-kick fixed points / equilibria
%   You will need the function CoupledVar.m to run Newton.m


%F_of_x=1;

%Set up an initial condition
x=x0;

%Set up a place to hold Newton iterates x_n 
Newton_pts=[];

%Set up a flag
flag=1; % will be set to zero if Newton converges, otherwise stays 1.

%Set up counter
cnt=0;

while cnt<10 &&  flag==1

cnt=cnt+1;
    
%Compute solution to variational equation along trajectory starting at
%x and lasting for time tau
[T,Y] = ode45(@CoupledVar,[0,tau],[x;1]);
post_flow=Y(end,1); %this is phi^tau of x
Vsoln=Y(end,2); %this is the derivative of phi^tau with respect to x

%Compute DF
DF=Vsoln-1;

%Compute F(x)
F_of_x=post_flow+k-x;

%Compute next Newton iterate
x=x-inv(DF)*F_of_x;

Newton_pts(cnt,1)=x;

if abs(F_of_x)< 10^(-10) %check whether x is nearly at equilibrium
    flag=0;
end

end

endpoint=Newton_pts(end,1);

end

