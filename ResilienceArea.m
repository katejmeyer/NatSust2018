%THIS SCRIPT APPROXIMATES THE AREA ABOVE A FLOW-KICK RESILIENCE BOUNDARY AND BELOW
%ITS HORIZONTAL ASYMPTOTE.

%For each k, find the minimum time it takes to flow forward
%that distance
%fun=@(x) 1./(x.*(1-(x/100)).*((x/20)-1)); %inverse of the vector field (i.e. dt/dx)
fun=@(x) 1./(x.*(1-(x/100)).*((x/20)-1).*(0.0002*x.^2-0.024*x+1.4)); 


krange1=-79.99:0.01:0; %go close to distance to threshold, but not quite
%krange2=-79.99:.01:-79.8; %get a little closer to threshold
%krange=cat(2,krange2, krange1);
ResilienceCurve=zeros(2,length(krange1));
kcount=0;
xmin=zeros(1,length(krange1));
x0=99.99;
for k=krange1
    kcount=kcount+1;
    %der=@(x) -(x.*(1-(x/100)).*((x/20)-1))+((x+k).*(1-((x+k)/100)).*(((x+k)/20)-1));
    der=@(x) -(x.*(1-(x/100)).*((x/20)-1).*(0.0002*x.^2-0.024*x+1.4))+((x+k).*(1-((x+k)/100)).*(((x+k)/20)-1).*(0.0002*(x+k).^2-0.024*(x+k)+1.4));
    xmin(kcount)=fzero(der,x0);
    x0=xmin(kcount);
   %find root eqn. fzero function needs the function and initial guess
%     %initial guess should be between 20 and 100. start with x0=99.9 and
%     then use previous answer for next x0
    ResilienceCurve(1,kcount)=integral(fun,xmin(kcount)+k,xmin(kcount)); %the tau that goes with k
    ResilienceCurve(2,kcount)= k; % the k
end

figure
plot(ResilienceCurve(1,:),-ResilienceCurve(2,:),'b')
title('resilience curve for existence of upper stable equilibrium')
xlabel('tau')
ylabel('k')
axis([0 8 0 85])
hold on
plot(fliplr(ResilienceCurve(1,:)),80*tanh(fliplr(ResilienceCurve(1,:))/5),'r')



kick=-fliplr(ResilienceCurve(2,:));
tau=fliplr(ResilienceCurve(1,:));
Area1=trapz(tau,80-kick) %trap rule d(tau) with unequal intervals
Area2=trapz(kick,tau) %trap rule d(kick) with equal intervals
avearea=(Area1+Area2)/2
