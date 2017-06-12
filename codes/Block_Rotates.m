function Out_img=Block_Rotates(In_img,Bz)
% version 2.26 night
if Bz==0
    Out_img=In_img;
    Rotation_key=0;
    return;
end
Out_img=In_img;
[m n]=size(In_img);
L=floor(m/Bz)*floor(n/Bz);
rand('state',2)
Rotation_key=floor(rand(L,1)/0.25)*90;  % in the range of [0 90 180 270]  (or 360==0 (if rand==1))

s=0;
for i=1:Bz:m-Bz+1
    for j=1:Bz:n-Bz+1
        temp=In_img(i:i+Bz-1,j:j+Bz-1);
        s=s+1;
        angle=Rotation_key(s);
        Out_img(i:i+Bz-1,j:j+Bz-1)=imrotate(temp,angle);   % imrotate旋转图像
    end
end
