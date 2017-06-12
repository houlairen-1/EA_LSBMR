function Out_img=Re_Block_Rotates(In_img,Bz)
% version 2.26 night
Out_img=In_img;
if Bz==0
    return;
end

[m n]=size(In_img);
L=floor(m/Bz)*floor(n/Bz);
rand('state',2)
Rotation_key=floor(rand(L,1)/0.25)*90;  % in the range of [0 90 180 270]  (or 360==0 (if rand==1))

s=0;
s=0;
for i=1:Bz:m-Bz+1
    for j=1:Bz:n-Bz+1
        temp=In_img(i:i+Bz-1,j:j+Bz-1);  
        s=s+1;
        Out_img(i:i+Bz-1,j:j+Bz-1)=imrotate(temp,-Rotation_key(s));
    end
end