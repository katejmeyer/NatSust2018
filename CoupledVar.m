function [ dydt ] = CoupledVar(t,y)
% gives ODE for fish population 1, along with varational equation to be solved
% simultaneously

dydt = zeros(2,1);
dydt(1)=y(1)*(1-y(1)/100)*(y(1)/20-1); %fish population 1 ODE
dydt(2)=(-1+3*(y(1)/25) - 3*(y(1)^2/2000))*y(2); %Variational Equation, along trajectory of y(1)

end