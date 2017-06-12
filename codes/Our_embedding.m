function [stego T Message]=Our_embedding(cover,rate)

cover=double(cover);
stego=double(cover); 
[m n]=size(cover); 
T=0;                                            % the threshold T 

Message= mod(randperm(floor(m*n*rate)),2);            
if mod(length(Message),2)==1
    Message=Message(1:end-1);               
end                                             %简单起见 信息长度为偶数      

temp=zeros(m*n,1);
% scanning ordering  
s=1; 
for i=1:2:m-1
    temp(s:s+n-1)=cover(i,:);
    temp(s+n:s+n+n-1)=cover(i+1,n:-1:1);
    s=s+2*n;
end

L=length(temp);                                     
Traveling_order=randperm(floor(L/2));                % the traveling order for the pixel pairs像素对的选取

bj=0; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%控制嵌入完成
for t=31:-1:0,
    if bj==1                                         % embedding complete 
        break;
    end
    if t==0                                          % using the typical LSB Mathcing Revisited method for data hiding   
        stego=cover;
        T=0;  
        return;             
    end

    % estimation of the embedding rate with a given t
    left=temp(1:2:end); right=temp(2:2:end);         % note |left|==|right| ,  % assuming m*n is even  
    if sum(abs(left-right)>=t)*2<length(Message)
        continue;
    end        
    
    % data embedding using the threshold t and the traveling order 
    s=1; 
    for i=1:floor(L/2)
        ind=(Traveling_order(i)-1)*2+1; 
        a=temp(ind); b=temp(ind+1); 
        if abs(a-b)<t
            continue;
        end
        if mod(a,2)==Message(s)
            if mod(floor(a/2)+b,2)~=Message(s+1)
                ran=sign(rand-0.5); 
                if ran==0
                    ran=1;
                end
                b=b+ran;
            end
        else
            if mod(floor((a-1)/2)+b,2)==Message(s+1)
                a=a-1;
            else
                a=a+1;
            end
        end
        % t -1 (at most) 
        
        %====================== boundary ======================= 
        % f(a,b)==f(a+/-4,b)
        if a==-1
            a=3;
        end

        if a==256
            a=252;
        end

        % f(a,b)=f(a,b+/-2)
        if b==-1
            b=1;
        end

        if b==256
            b=254;
        end
        
        % t -3 (at most)
        %====================== boundary =======================
        
        if abs(a-b)<t                     
            [temp(ind) temp(ind+1)]=Data_Readjust(a,b,temp(ind),temp(ind+1),t); 
        else
            temp(ind)=a; temp(ind+1)=b; 
        end
        s=s+2;               % 2 bits have been embedded
        
        if s>=length(Message)
            T=t; bj=1;  
            break;            
        end
    end                       % end for i  
end                           % end for t 

% Re scanning ordering  
s=1;
for i=1:2:m-1
    stego(i,1:n)=temp(s:s+n-1); s=s+n;
    stego(i+1,n:-1:1)=temp(s:s+n-1); s=s+n; 
end   

stego=uint8(stego);
figure; imshow(stego==cover); title([num2str(sum(sum(stego~=cover)/m/n/rate)) '   changed '])
 

