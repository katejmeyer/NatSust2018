%THIS FUNCTION GIVES A SIGN-REVERSED ODE FROM STOMMEL'S OCEAN BOX MODEL
%It was used to calculate the separatrix in the script StommelFigure.m.
function[dydt]=dydtMinusStommel(~,y)
lambda=(1/5);
R=2;
delta=1/6;

dydt=zeros(2,1);
dydt(1)=-(delta*(1-y(1))-(y(1)/lambda)*abs(-y(2)+R*y(1)));
dydt(2)=-(1-y(2)-(y(2)/lambda)*abs(-y(2)+R*y(1)));
end
