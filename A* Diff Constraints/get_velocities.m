function [resolution,actions] = get_velocities(u1,u2)
% This function is used to get resolution from angular velocities given.
actions= [ u2,u2;u1,u1;u2,u1; u1,0; u2,0;0,u2;0,u1;u1,u2];
r=0.035; L= 0.23;t=0.5;
actions= (actions*2*pi)/60;

for i=1:8
    ul = actions(i,1); ur=actions(i,2);
    theta= (r/L)*(ur-ul)*t;
    x= (r/2)*(ul+ur)*cos(theta)*t;
    y= (r/2)*(ul+ur)*sin(theta)*t;
    res(i)=min(abs(x),abs(y)); 
end
res(res==0)=inf;
resolution= min(res);
end
