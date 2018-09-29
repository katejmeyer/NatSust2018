%THIS SCRIPT CALCULATES FLOW-KICK TRAJECTORIES FOR A HARVESTED POPULATION
%The population's undisturbed dynamics are given by the ODE function dxdtAllee.m

%Trajectory A
kappa=-12; %kick size and direction
tau=0.25; %flow time
N=64; % number of flow-kick iterations
postkick=100; %initial population size
count=0;

figure
hold on

for i=1:N
    count=count+1;
    [T,X]=ode45(@dxdtAllee,[(count-1)*tau, count*tau],postkick); %flow 
    postkick=X(end)+kappa; %kick
    plot(T,X,'Color',[255/256 128/256 0],'LineWidth',1)
end

%Trajectory B
kappa=-40; %kick size and direction
tau=10/12; %flow time
N=15;
postkick=100; %initial position
count=0;

for i=1:N
    count=count+1;
    [T,X]=ode45(@dxdtAllee,[(count-1)*tau, count*tau],postkick); %flow
    postkick=X(end)+kappa; %kick
    plot(T,X,'Color',[204/256 0 0],'LineWidth',1)
end

axis([0 12 0 105])
xlabel('Time (years)')
ylabel('Population size')
