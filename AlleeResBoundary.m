%THIS SCRIPT PLOTS THE FLOW-KICK RESILIENCE BOUNDARY FOR ALLEE POPULATIONS 1 AND 2
%For each harvest (kick) size, the script approximates the minimum time it takes to
%population to recover by that magnitude. 

%Create the inverse of the vector field function, i.e. dt/dx
fun=@(x) 1./(x.*(1-(x/100)).*((x/20)-1)); %population 1
%fun=@(x) 1./(x.*(1-(x/100)).*((x/20)-1).*(0.0002*x.^2-0.024*x+1.4));
%%population 2, remove '%' to find resilience boundary for this population.

%Create a range of kick values 
krange=-79.8:0.1:0;  %go close to distance to threshold, but not quite

%Create an array to store points on the resilience boundary.
ResilienceCurve=zeros(2,length(krange));

%For each kick, calculate the minimum time needed to fully recover from the
%kick within the basin of attraction.
kcount=0;
for k=krange
    kcount=kcount+1;
    x0range=20.1-k:0.1:99.9; %identify a set of x values at which to start flowing (min computed over this set)
    TimeToFlow=zeros(1,length(x0range));
    x0count=0;
        for x0=x0range
            x0count=x0count+1;
            TimeToFlow(x0count)=integral(fun,x0+k,x0);%calculate time to flow from x0+k to x0
        end
    ResilienceCurve(1,kcount)= min(TimeToFlow); %the tau that goes with k
    ResilienceCurve(2,kcount)= k; % the k
end

figure
plot(ResilienceCurve(1,:),-ResilienceCurve(2,:))
title('Resilience boundary for population 1')
xlabel('flow time tau')
ylabel('kick size |kappa|')
axis([0 8 0 85])

