function [] = drawobstaclespace()

 %% Draw GUI = World space with Obstacles
 
%  figure('units','normalized','outerposition',[0 0 1 1])
hold on
axis([0 11.5 0 10.5])
ax = gca;
ax.XTick = [0:1:15];
ax.YTick = [0:1:11];

%% plot pillars
xcentre1=3.9;
ycentre1=9.65;
t=0:0.01:2*pi;
x1=0.405*cos(t)+xcentre1;
y1=0.405*sin(t)+ycentre1;
drawnow
plot(x1,y1)
fill(x1,y1,'b')

xcentre2=4.38;
ycentre2=7.36;
x2=0.405*cos(t)+xcentre2;
y2=0.405*sin(t)+ycentre2;
drawnow
plot(x2,y2)
fill(x2,y2,'b')

xcentre3=4.38;
ycentre3=2.74;
x3=0.405*cos(t)+xcentre3;
y3=0.405*sin(t)+ycentre3;
drawnow
plot(x3,y3)
fill(x3,y3,'b')

xcentre4=3.9;
ycentre4=0.45;
x4=0.405*cos(t)+xcentre4;
y4=0.405*sin(t)+ycentre4;
drawnow
plot(x4,y4)
fill(x4,y4,'b')

%% plot round table

xcentre5=1.4995;
ycentre5=8.3005;
x5=0.7995*cos(t)+xcentre5;
y5=0.7995*sin(t)+ycentre5;
drawnow
plot(x5,y5)
fill(x5,y5,'b')

xcentre6=3.0985;
ycentre6=8.3005;
x6=0.7995*cos(t)+xcentre6;
y6=0.7995*sin(t)+ycentre6;
drawnow
plot(x6,y6)
fill(x6,y6,'b')

xp1=[1.4995,1.4995,3.0985,3.0985];
yp1=[7.501,9.1,9.1,7.501];
drawnow
plot(xp1,yp1)
fill(xp1,yp1,'b')

%% plot rectangle obstacles

xp2=[4.38,4.38,5.29,5.29];
yp2=[3.15,4.98,4.98,3.15];
drawnow
plot(xp2,yp2)
fill(xp2,yp2,'b')

xp3=[5.29,5.29,7.12,7.12];
yp3=[2.65,3.41,3.41,2.65];
drawnow
plot(xp3,yp3)
fill(xp3,yp3,'b')

xp4=[4.74,4.74,7.48,7.48];
yp4=[0.35,1.87,1.87,0.35];
drawnow
plot(xp4,yp4)
fill(xp4,yp4,'b')

xp5=[6.85,6.85,11.1,11.1];
yp5=[0,0.35,0.35,0];
drawnow
plot(xp5,yp5)
fill(xp5,yp5,'b')

xp6=[7.79,7.79,8.96,8.96];
yp6=[0.35,0.93,0.93,0.35];
drawnow
plot(xp6,yp6)
fill(xp6,yp6,'b')

xp7=[9.27,9.27,11.1,11.1];
yp7=[0.35,1.12,1.12,0.35];
drawnow
plot(xp7,yp7)
fill(xp7,yp7,'b')

xp8=[7.845,7.845,9.365,9.365];
yp8=[2.67,3.84,3.84,2.67];
drawnow
plot(xp8,yp8)
fill(xp8,yp8,'b')

xp9=[10.52,10.52,11.1,11.1];
yp9=[1.7825,2.9525,2.9525,1.7825];
drawnow
plot(xp9,yp9)
fill(xp9,yp9,'b')

xp10=[10.19,10.19,11.1,11.1];
yp10=[3.625,4.485,4.485,3.625];
drawnow
plot(xp10,yp10)
fill(xp10,yp10,'b')

xp11=[10.52,10.52,11.1,11.1];
yp11=[4.485,5.655,5.655,4.485];
drawnow
plot(xp11,yp11)
fill(xp11,yp11,'b')

xp12=[7.44,7.44,11.1,11.1];
yp12=[6.21,6.97,6.97,6.21];
drawnow
plot(xp12,yp12)
fill(xp12,yp12,'b')

xp13=[8.32,8.32,9.18,9.18];
yp13=[8.27,10.1,10.1,8.27];
drawnow
plot(xp13,yp13)
fill(xp13,yp13,'b')

xp14=[9.83,9.83,10.26,10.26];
yp14=[9.19,10.1,10.1,9.19];
drawnow
plot(xp14,yp14)
fill(xp14,yp14,'b')

end

