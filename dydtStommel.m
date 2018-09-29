%THIS FUNCTION GIVES THE ODE FOR STOMMEL'S OCEAN BOX MODEL
function[dydt]=dydtStommel(~,y)
lambda=(1/5);
R=2;
delta=1/6;

dydt=zeros(2,1);
dydt(1)=delta*(1-y(1))-(y(1)/lambda)*abs(-y(2)+R*y(1));
dydt(2)=1-y(2)-(y(2)/lambda)*abs(-y(2)+R*y(1));
end
