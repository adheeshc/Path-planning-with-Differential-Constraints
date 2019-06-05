function [path]= final(xstart,ystart,resolution)
%% Draw GUI = World space with Obstacles
drawobstaclespace();
hold on
%% Taking Input from User
[resolution,actions]= get_velocities(50,100);
check=1;
while(check==1) %While loop to check if values of (xstart,ystart,xgoal,ygoal) are valid or not.
title('Click to set start point');
[xnew,ynew] = ginput(1);
xstart=(floor(xstart/resolution))*resolution; 
ystart=(floor(ystart/resolution))*resolution; 
rectangle('Position',[xstart ystart resolution resolution ], 'FaceColor','red','EdgeColor','k');

title('Click to set target point');
[xgoal,ygoal] = ginput(1);
xgoal=(floor(xgoal/resolution))*resolution; 
ygoal=(floor(ygoal/resolution))*resolution; 

    if(~(checkposition(xstart,ystart,resolution)))
        uiwait(msgbox('Invalid Start Point Input'));
    elseif(~(checkposition(xgoal,ygoal,resolution)))
         uiwait(msgbox('Invalid End Point Input'));
    else
         check=0;
    end
end

rectangle('Position',[xgoal ygoal resolution resolution ], 'FaceColor','red','EdgeColor','k');

%% Initialize
theta=0;
vel=[0 0 0];
t=10;

open_list= [xstart,ystart,theta];
close_list= [0 0 0];
explored_nodes=[xstart,ystart,theta]; %all explored nodes
parent_node(:,:,1)=[1 1]; %parentnode 


open_count=2; % count for open_list
node_count=2; % count for all explored nodes 
parent_count=1; % Initialing parent node count

cost(1)= 0; % c2c of all nodes in open_list
total_c2c=0;% C2c of all possible nodes
cost2come(1)=0; % C2c of all nodes in open_list

%% Main Loop

while(~isempty(open_list)) 

[~,index]=min(cost);
x= open_list(index,1); y= open_list(index,2); theta=open_list(index,3);
[~,parent_count]=ismember([x y theta],explored_nodes,'rows');
[~,c2ccount]=ismember([x y theta],open_list,'rows');
if (abs(x-xgoal)< 0.1 && abs(y-ygoal)< 0.1)
    xgoal=x;ygoal=y;thetagoal=theta
    break
end

%% (Ul,Ur)= (100,100)
ul=actions(1,1);ur=actions(1,2); c2cdiff=0.1833;
[xy,v]=diffconstraints(ul,ur,x,y,theta,resolution,t);
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c,vel]=new_node(xy,explored_nodes,close_list,parent_node,xgoal,ygoal,node_count,c2ccount,parent_count,open_count,open_list,cost,c2cdiff,cost2come,total_c2c,resolution,vel,v);
%% (Ul,Ur)= (50,50)
ul=actions(2,1);ur=actions(2,2);c2cdiff=0.0916;
[xy,v]=diffconstraints(ul,ur,x,y,theta,resolution,t);
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c,vel]=new_node(xy,explored_nodes,close_list,parent_node,xgoal,ygoal,node_count,c2ccount,parent_count,open_count,open_list,cost,c2cdiff,cost2come,total_c2c,resolution,vel,v);
%% (Ul,Ur)= (100,50)
ul=actions(3,1);ur=actions(3,2);c2cdiff=0.1374;
[xy,v]=diffconstraints(ul,ur,x,y,theta,resolution,t);
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c,vel]=new_node(xy,explored_nodes,close_list,parent_node,xgoal,ygoal,node_count,c2ccount,parent_count,open_count,open_list,cost,c2cdiff,cost2come,total_c2c,resolution,vel,v);
%% (Ul,Ur)= (50,0)
ul=actions(4,1);ur=actions(4,2);c2cdiff=0.0458;
[xy,v]=diffconstraints(ul,ur,x,y,theta,resolution,t);
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c,vel]=new_node(xy,explored_nodes,close_list,parent_node,xgoal,ygoal,node_count,c2ccount,parent_count,open_count,open_list,cost,c2cdiff,cost2come,total_c2c,resolution,vel,v);
%% (Ul,Ur)= (100,0)
ul=actions(5,1);ur=actions(5,2);c2cdiff=0.0916;
[xy,v]=diffconstraints(ul,ur,x,y,theta,resolution,t);
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c,vel]=new_node(xy,explored_nodes,close_list,parent_node,xgoal,ygoal,node_count,c2ccount,parent_count,open_count,open_list,cost,c2cdiff,cost2come,total_c2c,resolution,vel,v);
%% (Ul,Ur)= (0,100)
ul=actions(6,1);ur=actions(6,2);c2cdiff=0.0916;
[xy,v]=diffconstraints(ul,ur,x,y,theta,resolution,t);
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c,vel]=new_node(xy,explored_nodes,close_list,parent_node,xgoal,ygoal,node_count,c2ccount,parent_count,open_count,open_list,cost,c2cdiff,cost2come,total_c2c,resolution,vel,v);
%% (Ul,Ur)= (0,50);
ul=actions(7,1);ur=actions(7,2);c2cdiff=0.0458;
[xy,v]=diffconstraints(ul,ur,x,y,theta,resolution,t);
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c,vel]=new_node(xy,explored_nodes,close_list,parent_node,xgoal,ygoal,node_count,c2ccount,parent_count,open_count,open_list,cost,c2cdiff,cost2come,total_c2c,resolution,vel,v);
%% (Ul,Ur)= (50,100);
ul=actions(8,1);ur=actions(8,2);c2cdiff=0.1374;
[xy,v]=diffconstraints(ul,ur,x,y,theta,resolution,t);
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c,vel]=new_node(xy,explored_nodes,close_list,parent_node,xgoal,ygoal,node_count,c2ccount,parent_count,open_count,open_list,cost,c2cdiff,cost2come,total_c2c,resolution,vel,v);

%% Popping out of open list
cost(index)=[];
open_list(index,:)=[];
cost2come(index)=[];
open_count=open_count-1;
%% Adding in close list
close_list= [x y theta;close_list];
end

%% Back Tracking the parent node to find the path
fin=0;l=1;
[~, node_countfinal]= ismember([xgoal,ygoal thetagoal],explored_nodes,'rows');
node_count=node_countfinal;
plt=[explored_nodes(node_count,:), vel(node_count,:)];
% Storing the Path
path(l,:)=[plt(1) plt(2) plt(4) plt(5) plt(6) ];l=l+1;

parent_count= parent_node(1,2,node_count);
plt=[explored_nodes(parent_count,:), vel(parent_count,:)];
path(l,:)=[plt(1) plt(2) plt(4) plt(5) plt(6) ];l=l+1;

%Back Tracking
while(fin==0)
    parent_count= parent_node(1,2,parent_count);
    plt=[explored_nodes(parent_count,:), vel(parent_count,:)];
    if(plt(1)==xstart && plt(2)==ystart)
        fin=1;
    end
    path(l,:)=[plt(1) plt(2) plt(4) plt(5) plt(6) ];l=l+1;
end
% Inverting the array, as we want path from first to last.
path= flipud(path);
xc=path(:,1); yc=path(:,2);
hold on
% Plotting Final path
for c=2:size(path,1) 
 plot(xc(c-1:c),yc(c-1:c),'r');
end
end
