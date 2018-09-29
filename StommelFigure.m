%THIS SCRIPT PLOTS THE PHASE PORTRAITS AND FLOW-KICK TRAJECTORIES FOR
%STOMMEL'S OCEAN BOX MODEL (FIGURE 5). 
%Although Stommel's model reduces to coordinates x and y corresponding to 
%salinity and temperature in the low latitude box, 
%the coordinates -x and -y were used in the paper to focus on the high latitude ocean box. 
%to recreate Figure 5, simply rotate figures by 180 degrees and reverse the
%signs on the axes.

%Create phase portrait (Figure 5a)
figure
hold on
    %Trajectories
    for i=[0 0.2 0.4 1]
        [~,Y]=ode45(@dydtStommel,[0,200],[0 i]);
        plot(Y(:,1),Y(:,2),'k')
    end
    for i=[0.5]
        [~,Y]=ode45(@dydtStommel,[0,200],[1 i]);
        plot(Y(:,1),Y(:,2),'k')
    end
    for i=[0.1 0.3 0.7]
        [~,Y]=ode45(@dydtStommel,[0,200],[i 0]);
        plot(Y(:,1),Y(:,2),'k')
    end
    for i=[0.1 0.3 0.4 0.45 0.5 0.7 0.9]
        [~,Y]=ode45(@dydtStommel,[0,200],[i 1]);
        plot(Y(:,1),Y(:,2),'k')
    end

    %Separatrix
    b=[0.35184, 0.7651];
    [~,S1]=ode45(@dydtMinusStommel,[0,2.8],b-[0 0.001]);
    plot(S1(:,1),S1(:,2),'k--')
    [~,S2]=ode45(@dydtMinusStommel,[0,1.7],b+[0 0.001]);
    plot(S2(:,1),S2(:,2),'k--')
    
    %Stable Manifolds
    [~,Y]=ode45(@dydtStommel,[0,200],b-[0.001 0]); %0th order approximation to starting point
    plot(Y(:,1),Y(:,2),'k')
    [~,Y]=ode45(@dydtStommel,[0,200],b+[0.001 0]); %0th order approximation to starting point
    plot(Y(:,1),Y(:,2),'k')
    
    %Equilibria
    a=[0.135, 0.48358];
    b=[0.35184, 0.7651];
    c=[0.43205, 0.82028];
    plot(a(1),a(2),'ko')
    plot(b(1),b(2),'ko')
    plot(c(1),c(2),'ko')
    
    axis([0 1 0 1])
    
%Exhibit outcome of short recovery period: stabilize in basin of attr. of a
%(Figure 5b)
figure
hold on

kappa=[0.1 0]; %kick 
tau=0.1; %flow time
N=20;
postkick=a; %initial position

for i=1:N
    [~,X]=ode45(@dydtStommel,[0,tau],postkick);
    plot(X(:,1),X(:,2),'b')
    postkick=X(end,:)+kappa;
end

    %Separatrix
    plot(S1(:,1),S1(:,2),'k--')
    plot(S2(:,1),S2(:,2),'k--')
    
    %Equilibria
    a=[0.135, 0.48358];
    b=[0.35184, 0.7651];
    c=[0.43205, 0.82028];
    plot(a(1),a(2),'ko')
    plot(b(1),b(2),'ko')
    plot(c(1),c(2),'ko')
    
axis([0 1 0 1])

%Exhibit outcome of long recovery period: stabilize in basin of attr. of c
%(Figure 5c)
figure
hold on

kappa=[0.1 0]; %kick 
tau=1; %flow time
N=10;
postkick=a; %initial position

for i=1:N
    [~,X]=ode45(@dydtStommel,[0,tau],postkick);
    plot(X(:,1),X(:,2),'r')
    postkick=X(end,:)+kappa;
end

    %Separatrix
    plot(S1(:,1),S1(:,2),'k--')
    plot(S2(:,1),S2(:,2),'k--')
    
    %Equilibria
    a=[0.135, 0.48358];
    b=[0.35184, 0.7651];
    c=[0.43205, 0.82028];
    plot(a(1),a(2),'ko')
    plot(b(1),b(2),'ko')
    plot(c(1),c(2),'ko')
    
axis([0 1 0 1])

%Exhibit outcome of switching disturbance pattern to recovery time of 1
%once stabilized at flow-kick equilibrium for recovery time 0.1 (Figure 5d)
figure
hold on

kappa=[0.1 0]; %kick 
tau=0.1; %flow time
N=20;
postkick=a; %initial position

for i=1:N
    [~,X]=ode45(@dydtStommel,[0,tau],postkick);
    plot(X(:,1),X(:,2),'b')
    postkick=X(end,:)+kappa;
end

tau=1; %lengthened flow time

for i=1:N
    [~,X]=ode45(@dydtStommel,[0,tau],postkick);
    plot(X(:,1),X(:,2),'r')
    postkick=X(end,:)+kappa;
end
    
%Separatrix
    plot(S1(:,1),S1(:,2),'k--')
    plot(S2(:,1),S2(:,2),'k--')
    
    %Equilibria
    a=[0.135, 0.48358];
    b=[0.35184, 0.7651];
    c=[0.43205, 0.82028];
    plot(a(1),a(2),'ko')
    plot(b(1),b(2),'ko')
    plot(c(1),c(2),'ko')
    
axis([0 1 0 1])