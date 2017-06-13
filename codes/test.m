clc
clear all
close all
img=imread('../data/cover/test256.jpg');
%img=imread('../data/cover/Lena256.bmp');

cover=img;
[m,n]=size(cover);

rate=0.4;

[stego,Bz_index,T,Message]=Main_Edge_Adaptive(cover,rate);

imwrite(stego,'../data/stego/test0.4.jpg');
%imwrite(stego,'../data/stego/Lena0.4.jpg');
figure; 
subplot(1,3,1);imshow(stego==cover);title([num2str(sum(sum(stego~=cover)/m/n)) 'changed ']);
subplot(1,3,2);imshow(cover);title('cover');
subplot(1,3,3);imshow(stego);title('stego');
