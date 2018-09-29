%THIS SCRIPT PLOTS THE FLOW-KICK RESILIENCE BOUNDARY FOR A MODEL LAKE
%For each nutrient pulse (kick) size, the script approximates the minimum time it takes for phosphorus 
%levels to recover by that magnitude. 

%Parameters
L=25; %background input rate of P from the watershed
s=0.5; %linear P loss rate
r=50; %maximum P recycling rate from sediments
q=8; %parametrizes sigmoid recycling curve shape
m=100; % "

%Create the inverse of the vector field function, i.e. dt/dx
fun=@(x) 1./(L-s*x+r*(x.^q)./(m^q+x.^q)); %inverse of the vector field (i.e. dt/dx)

%Create a range of kick values 
krange=0:1:49.5;  

%Create an array to store points on the resilience boundary.
ResilienceCurve=zeros(2,length(krange));

%For each kick, calculate the minimum time needed to fully recover from the
%kick within the basin of attraction.
kcount=0;
for k=krange
    kcount=kcount+1;
    x0range=50.417:0.5:100-k; %identify a range of x values at which to start flowing (min computed over this set)
    TimeToFlow=zeros(1,length(x0range));
    x0count=0;
        for x0=x0range
            x0count=x0count+1;
            TimeToFlow(x0count)=-integral(fun,x0,x0+k);%calculate time to flow from x0+k to x0
        end
    ResilienceCurve(1,kcount)= min(TimeToFlow); %the tau that goes with k
    ResilienceCurve(2,kcount)= k; % the k
end

figure
plot(ResilienceCurve(1,:),ResilienceCurve(2,:))
title('resilience curve for lake P model')
xlabel('flow time tau')
ylabel('kick kappa')
axis([0 15 0 50])


