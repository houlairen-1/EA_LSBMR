function [a1 b1]=Data_Readjust(a,b,ori_a,ori_b,t)
% note: f(a,b)=f(a+/-4,b) f(a,b)=f(a,b+/-2)

min_error=inf; 

a1_Set=[a a-4 a+4]; b1_Set=[b b-2 b+2 b-4 b+4]; 

for i=1:3,
    temp_a1=a1_Set(i); 
    if temp_a1>255 || temp_a1<0
        continue;
    end
    for j=1:5
        temp_b1=b1_Set(j); 
        if temp_b1>255 || temp_b1<0
            continue;
        end
        if abs(temp_a1-temp_b1)<t
            continue;
        end
        new_error=abs(temp_a1-ori_a)+abs(temp_b1-b);
        if new_error<min_error
            a1=temp_a1; b1=temp_b1;
            min_error=new_error;
        end
    end
end