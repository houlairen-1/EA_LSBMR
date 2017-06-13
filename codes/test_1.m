clc
clear all
close all
img=imread('../data/cover/luxq512.jpg');
%img=imread('../data/cover/Lena256.bmp');

cover=img;
[m,n]=size(cover);

for i=1:4
    rate = i/10;
    [stego,Bz_index,T,Message]=Main_Edge_Adaptive(cover,rate);

    imwrite(stego,['../data/stego/luxq' num2str(rate) '.jpg']);

    subplot(2, 2, i);imshow(stego==cover);
    title(['rate=' num2str(rate) ' T=' num2str(T)]);
end
