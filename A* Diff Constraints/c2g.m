function [c2g] = c2g(x,y,xgoal,ygoal)
%% Euclidian Distance


c2g= (sqrt((x-xgoal).^2 + (y-ygoal).^2));
%% Manhattan Distance
% 
% linear_cost=max(abs(xtarget-x),abs(ytarget-y)); 
% diag_cost=min(abs(xtarget-x),abs(ytarget-y));
% cost2go=((linear_cost-diag_cost)*10)+(diag_cost*floor((sqrt(2)*10)));

%diagonal dist will always be less than linear distance

%%%%%%%%%%%%%
%REFERENCE

%https://math.stackexchange.com/questions/139600/how-do-i-calculate-euclidean-and-manhattan-distance-by-hand

%%%%%%%%%%%%%%%%

end