function [stego,Message]=LSBM_Revisited(cover,rate)
% version 3.8 night 
% note the function just simulates the process of LSB revisited algorithm, it can
% not extract the secert message from the stego correctly. 

% embemdding rate 0<=rate<=1
if rate<0 || rate>1
    disp('Error Input');
    stego=0;
    Message=0;
    return;    
end

if rate==0
    stego=cover;
    Traveling_order=0;
    Message=0;
    return;
end

cover=double(cover);
stego=double(cover); 
[m n]=size(cover); 

Message=rand(floor((m*n)*rate),1)>0.5;           % 秘密信息的生成
if mod(length(Message),2)==1
    Message=Message(1:end-1);               
end                                              % 简单起见  信息长度为偶数      

temp=stego(:);%转换成一列
%%%%%%%%%%%%%%%%% 扫描的顺序 
s=1;%%%%%%%%%%控制嵌入完成的   
for i=1:2:m-1
    temp(s:s+n-1)=cover(i,:);
    temp(s+n:s+n+n-1)=cover(i+1,n:-1:1);
    s=s+2*n;
end 

L=floor(length(temp));%%%%%%%%%%%%%%%%%%%%%%%%%%这里L其实等于m*n;
Traveling_order=randperm(floor(L/2));           % 像素对的顺序         
s=1; 
for i=1:floor(L/2)
    ind=(Traveling_order(i)-1)*2+1; %%%%%%%%%%%%%%%%%%为什么这么处理
    a=temp(ind); b=temp(ind+1); 
    if mod(a,2)==Message(s)
        if mod(floor(a/2)+b,2)~=Message(s+1)
            ran=sign(rand-0.5); %%%%%%%%%%%%%%产生随机地+-1序列
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
    %====================== boundary ======================= 
    
    temp(ind)=a; temp(ind+1)=b; s=s+2;
    if s>=length(Message)
        break;
    end
end

% Re scanning ordering  
s=1;
for i=1:2:m-1
    stego(i,1:n)=temp(s:s+n-1); s=s+n;
    stego(i+1,n:-1:1)=temp(s:s+n-1); s=s+n; 
end   

stego=uint8(stego);
%figure; imshow(stego~=cover); title([num2str(sum(sum(stego~=cover)/m/n)) '   changed '])
