function [overlap]= checkposition(x,y,res)
%for pillars
z1=((x-3.9)^2+(y-9.65)^2-(0.405+res)^2);
z2=((x-4.38)^2+(y-7.36)^2-(0.405+res)^2);
z3=((x-4.38)^2+(y-2.74)^2-(0.405+res)^2);
z4=((x-3.9)^2+(y-0.45)^2-(0.405+res)^2);

%for round table
z5=((x-1.4995)^2+(y-8.3005)^2-(0.7995+res)^2);
z6=((x-3.0985)^2+(y-8.3005)^2-(0.7995+res)^2);

%CHECK
if (x>=0 && x<=11.1 && y>=0 && y<=10.1)
    %for rectangle obstacles
    if (x>=4.38-res && x<=5.29+res && y>=3.15-res && y<=4.98+res) 
        overlap= false;        
    elseif (x>=5.29-res && x<=7.12+res && y>=2.65-res && y<=3.41+res) 
        overlap= false;        
    elseif (x>=4.74-res && x<=7.48+res && y>=0.35-res && y<=1.87+res) 
        overlap= false;        
    elseif (x>=6.85-res && x<=11.1 && y>=0 && y<=0.35+res) 
        overlap= false;        
    elseif (x>=7.79-res && x<=8.96+res && y>=0.35-res && y<=0.93+res) 
        overlap= false;          
    elseif (x>=9.27-res && x<=11.1 && y>=0.35-res && y<=1.12+res) 
        overlap= false;          
    elseif (x>=7.845-res && x<=9.365+res && y>=2.67-res && y<=3.84+res) 
        overlap= false;         
    elseif (x>=10.52-res && x<=11.1 && y>=1.7825-res && y<=2.9525+res) 
        overlap= false;      
    elseif (x>=10.19-res && x<=11.1 && y>=3.625-res && y<=4.485+res) 
        overlap= false;          
    elseif (x>=10.52-res && x<=11.1 && y>=4.485-res && y<=5.655+res) 
        overlap= false;          
    elseif (x>=7.44-res && x<=11.1 && y>=6.21-res && y<=6.97+res) 
        overlap= false;          
        
    elseif (x>=8.32-res && x<=9.18+res && y>=8.27-res && y<=10.1) 
        overlap= false;          
    elseif (x>=9.83-res && x<=10.26+res && y>=9.19-res && y<=10.1) 
        overlap= false;          
    
    %for pillars
    elseif (z1<=0) 
        overlap= false;
    elseif (z2<=0) 
        overlap= false;
    elseif (z3<=0) 
        overlap= false;
    elseif (z4<=0) 
        overlap= false;
    
    %for round table
    elseif (z5<=0)
        overlap= false;
    elseif (z6<=0)
        overlap= false;
    elseif (x>=1.4995-res && x<=3.0985+res && y>=7.501-res && y<=9.1+res)
        overlap=false;
    else
        overlap= true;
    end
else
    overlap= false;
end
end
