%Question 5
for i=1:6
    road_quston = [0 1 0 0 1 1;
               1 0 1 0 0 1;
               0 1 0 1 0 1;
               0 0 1 0 1 1;
               1 0 0 1 0 1;
               1 1 1 1 1 0];
    while(any(road_quston(i,:)))
        chosen = 1;
        road_quston(i,chosen) = 0;
        
        while(road_quston(i,chosen) == 0)
            chosen = random('Poisson',3);
            while(chosen == 0)
                chosen = random('Poisson',3);
            end
        end
    
        if(road_quston(i,chosen) == 1)
            road_quston(i,chosen) = 0;
        end
         i = chosen;
    end
end

