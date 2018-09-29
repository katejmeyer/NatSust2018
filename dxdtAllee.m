%THIS FUNCTION GIVES THE RIGHT HAND SIDE OF THE ODE FOR ALLEE POPULATION 1
function dxdt = dxdtAllee(~,x)
dxdt = x.*(1-(x/100)).*((x/20)-1);
end