function [stego,Bz_index,T,Message]=Main_Edge_Adaptive(cover,rate)
% input: cover image and embedding rate
% output: the stego using the proposed method
 
stego=cover;    
[m n]=size(stego);                                    
T=0;    % Threshold 

% embemdding rate: 0<=rate<=1
if rate<0 || rate>1
    disp('Error Input');
    return;    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%
if rate==1    % 嵌入率为1时，与之前的LSBMR一样
    [stego Message]= LSBM_Revisited(cover,rate); 
    sum(sum(stego~=cover)/m/n)
    Bz_index=0;
    T=0;
    return;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Rotation_Block_size = [0 4 8 12]; 
ind = randperm(3);
Bz_index=ind(1);
Bz=Rotation_Block_size(Bz_index+1);    % random block sizes [0 4 8 12]
Out_img=Block_Rotates(cover,Bz);    % Block Rotations for cover 

[stego T Message]=Our_embedding(Out_img,rate);    

if T==0    % using the typical LSB Mathcing Revisited method for data hiding
   [stego,Message]= LSBM_Revisited(cover,rate);
end

stego = Re_Block_Rotates(stego,Bz); 
