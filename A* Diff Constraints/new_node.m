function [explored_nodes,Parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c,vel]=new_node(xy,explored_nodes,close_list,Parent_node,xgoal,ygoal,node_count,c2ccount,parent_count,open_count,open_list,cost,c2cdiff,cost2come,total_c2c,resolution,vel,v);

if (checkposition(xy(1),xy(2),resolution))            
   if (~ismember([xy(1) xy(2) xy(3)],close_list,'rows'))     
        
        cost2come(open_count) = cost2come(c2ccount)+c2cdiff;
        cost2go= c2g(xy(1),xy(2),xgoal,ygoal);
        total_cost= cost2come(open_count)+cost2go;
       
        if (ismember([xy(1) xy(2) xy(3)],open_list,'rows'))      
            [~,index]= ismember([xy(1) xy(2) xy(3)],open_list,'rows');
            if (cost2come(open_count)< cost2come(index))
                Parent_node(:,:,node_count)=[node_count,parent_count];
                cost(index)=total_cost;
                cost2come(index)=cost2come(open_count);
            else
                Parent_node(:,:,node_count)= [node_count,0];
            end
            
        else
            cost(open_count)= total_cost;
            Parent_node(:,:,node_count)= [node_count,parent_count];
            open_list=[open_list; xy(1) xy(2) xy(3)];
            total_c2c=[total_c2c ,cost2come(open_count)];
            explored_nodes= [explored_nodes;xy(1) xy(2) xy(3)];        
            vel=[vel;v];
            open_count=open_count+1;
            node_count=node_count+1;

        end
    
        % To Visualize output
        rectangle('Position',[xy(1) xy(2) resolution resolution ], 'FaceColor','yellow','EdgeColor','r');pause(0.0001);                     
            
   end
end
end



