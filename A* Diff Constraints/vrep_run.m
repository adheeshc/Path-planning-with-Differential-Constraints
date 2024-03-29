clc;
clear all;
close all;

% Initialize Connection with Vrep
disp('Program started');
vrep=remApi('remoteApi'); 
vrep.simxFinish(-1);
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);

%% Checking For Connection
if (clientID>-1)
    disp('Connected to remote API server');
        
    %% Defining Handles 
    [ ~,lmotor]=vrep.simxGetObjectHandle(clientID,'wheel_left_joint',vrep.simx_opmode_blocking);
    [ ~,rmotor]=vrep.simxGetObjectHandle(clientID,'wheel_right_joint',vrep.simx_opmode_blocking);
    [ ~,dummy]=vrep.simxGetObjectHandle(clientID,'Dummy',vrep.simx_opmode_blocking);
    [ ~,bot]=vrep.simxGetObjectHandle(clientID,'Turtlebot2',vrep.simx_opmode_blocking);
        
    %% Calling A-star for path Planning
    % Getting Initial position of turtlebot from vrep environment
    [~,pos]=vrep.simxGetObjectPosition(clientID, bot,dummy,vrep.simx_opmode_blocking);
    % Setting resolution for node generation. 
    resolution=0.25;
    % Getting Path
    tic
%     path= astarwithdiffconstraints(pos(1), pos(2), resolution);
    path= final(pos(1), pos(2), resolution);
    toc
         
    %% Passing Commands to Vrep once path is found.
    % Initializing Variables
    t=0; % To keep track of time of vrep simulation.
    newxtheta(1)=0; % Slope for succesive nodes generated in path
    vel=[0 0 0 ]; % [ Vx vy thetadot]
    ul=0;ur=0; % Initial wheel velocities are zero
    l=1;  % variable for t array    
     
    % Setting Initial Velocities to zero.
    [~]=vrep.simxSetJointTargetVelocity( clientID,lmotor, ul,vrep.simx_opmode_blocking);  
    [~]=vrep.simxSetJointTargetVelocity( clientID,rmotor, ur,vrep.simx_opmode_blocking); 
         
    % Getting Initial Simulation Time
    [ r15, t(l)]=vrep.simxGetFloatSignal( clientID,'Turtlebot2_simulation_time',vrep.simx_opmode_blocking);l=l+1;

    % loop to make robot set orientation and translation for each node in path. 
    for i=2:size(path,1)
         % Getting Orientation
         [~,theta]=vrep.simxGetObjectOrientation(clientID, bot,dummy,vrep.simx_opmode_blocking);
         %   Calculationg Orientation from Path
         newxtheta(i)= atan2((path(i,2)-path((i-1),2)),(path(i,1)-path((i-1),1)));
         w=10; % Setting roatation velocity of wheels. (in rad/s)
         k=1; % variable for while loop

         %% Setting orientation
         disp('Turning');
%        [ r12, tt(lt)]=vrep.simxGetFloatSignal( clientID,'Turtlebot2_simulation_time',vrep.simx_opmode_blocking);lt=lt+1;
         while(k==1)
            diff=  abs(abs(theta(3))-abs(newxtheta(i)));
           if(diff<0.07)
               break
           end
           if (theta(3)<newxtheta(i))
               % taking left
               %disp('Turning left');
               ul=-w;ur=w;
               [r1]=vrep.simxSetJointTargetVelocity( clientID,lmotor, ul,vrep.simx_opmode_blocking);  
               [r2]=vrep.simxSetJointTargetVelocity( clientID,rmotor, ur,vrep.simx_opmode_blocking); 
           else
               %taking right
               ul=w;ur=-w;
               %disp('Turning right');
               [r3]=vrep.simxSetJointTargetVelocity( clientID,lmotor, ul,vrep.simx_opmode_blocking);  
               [r4]=vrep.simxSetJointTargetVelocity( clientID,rmotor, ur,vrep.simx_opmode_blocking); 
           end
           [~,theta]=vrep.simxGetObjectOrientation(clientID, bot,dummy,vrep.simx_opmode_blocking);
           
         end
          [~,theta]=vrep.simxGetObjectOrientation(clientID, bot,dummy,vrep.simx_opmode_blocking);
           vel=[vel;diffconstraints(ul,ur,theta(3))];

          [ r12, t(l)]=vrep.simxGetFloatSignal( clientID,'Turtlebot2_simulation_time',vrep.simx_opmode_blocking);l=l+1;
          disp('Done Turning');
          
          % Once Orientation set, angular velocities are returned back to zero
         [~]=vrep.simxSetJointTargetVelocity( clientID,lmotor, 0,vrep.simx_opmode_blocking);  
         [~]=vrep.simxSetJointTargetVelocity( clientID,rmotor, 0,vrep.simx_opmode_blocking); 
      
          %% Setting Position
         [~,pos]=vrep.simxGetObjectPosition(clientID, bot,dummy,vrep.simx_opmode_blocking);
         w=10; % velocity for going staright
         k=1;
         disp('Moving Forward');tempdist=inf;
%         [ r13, ts(ls)]=vrep.simxGetFloatSignal( clientID,'Turtlebot2_simulation_time',vrep.simx_opmode_blocking);ls=ls+1;

         while(k==1)
              dist= sqrt((pos(1)-path(i,1)).^2 + (pos(2)-path(i,2)).^2);
              disp(dist);
              if(dist< 0.5 || abs(dist) - 1e-3>abs(tempdist))
                  break;
              end
               [r5]=vrep.simxSetJointTargetVelocity( clientID,lmotor, w,vrep.simx_opmode_blocking);  
               [r6]=vrep.simxSetJointTargetVelocity( clientID,rmotor, w,vrep.simx_opmode_blocking); 
       
               [r10,pos]=vrep.simxGetObjectPosition(clientID, bot,dummy,vrep.simx_opmode_blocking);
                tempdist=dist; 
         end
         [~,theta]=vrep.simxGetObjectOrientation(clientID, bot,dummy,vrep.simx_opmode_blocking);
         vel=[vel;diffconstraints(w,w,theta(3))];

         [ r13, t(l)]=vrep.simxGetFloatSignal( clientID,'Turtlebot2_simulation_time',vrep.simx_opmode_blocking);l=l+1;

          disp('Done Moving Forward');

         end
         [r8]=vrep.simxSetJointTargetVelocity( clientID,lmotor, 0,vrep.simx_opmode_blocking);  
         [r9]=vrep.simxSetJointTargetVelocity( clientID,rmotor, 0,vrep.simx_opmode_blocking); 
         disp('End Point Reached');
        
         %% Make Text File
         maketext(vel,t);
         %% End Connection with Vrep
         vrep.simxFinish(-1);
 else
        disp('Failed connecting to remote API server');
 end
 
vrep.delete(); 
