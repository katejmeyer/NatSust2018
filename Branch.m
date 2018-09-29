% This script traces out a branch of fixed points for a flow-kick map using
% Newton's method and parameter continuation

%Fix tau
tau = 0.25;

%Pick a k value to start the branch of fixed points
k0=0;
%choose the interval between k values
kstep=-0.1;

%Make places to hold k's and fixed points
kList=[];
FxdPts=[];

%Make an initial guess of a fixed point to start Newton's method
guess=100; %50 for unstable branch

%Find fixed point for first and second k values
[endpoint,~]=Newton(tau,k0,guess);
FxdPts(1)=endpoint;
kList(1)=k0;

k=k0+kstep;%new k value
[endpoint,flag]=Newton(tau,k,FxdPts(1));
FxdPts(2)=endpoint;
kList(2)=k;


maxIterations=131;
for i=3:maxIterations % additional points on branch of fixed points to find
    k1=k+kstep; %keep both variables in play in order to lessen step size if needed
    guess=FxdPts(i-1)+kstep*(FxdPts(i-1)-FxdPts(i-2))/(kList(i-1)-kList(i-2)); % linear extrapolation of guess from previous two fixed points
    [endpoint,flag]=Newton(tau,k1,guess); %attempt to find new fixed point using Newton's method
    while flag == 1 && kstep > 0.0001 %reduce step size when Newton not converging
        kstep=kstep/2;
        k1=k+kstep;
        guess=FxdPts(i-1)+kstep*(FxdPts(i-1)-FxdPts(i-2))/(kList(i-1)-kList(i-2)); %adjust linear extrapolation of guess to account for smaller step size
        [endpoint,flag]=Newton(tau,k1,guess);
    end
    FxdPts(i)=endpoint; %record fixed point
    kList(i)=k1; %record corresponding k
    k=k1; %update k for next time through loop
end    

%plot the branch of fixed points as a function of k values
plot(kList,FxdPts)

%allow plot of next branch to be superimposed on this plot
hold on


    