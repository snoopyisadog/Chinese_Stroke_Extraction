%clear; clc;

tic
I = imread('4e39.png');
figure(1);imshow(I);
im = binarize(I);
%figure(2);imshow(im);

[ PBOD, pt ] = get_PBOD(im);

PPOD = get_PPOD(PBOD);

rho = rho_space(im, PPOD, pt);
toc

tic
[ pics ] = extract_rho( rho, pt );

toc
restore = ones(132,132);
for i = 2:size(pics,1);
    figure(i);
    a = pics(i,:,:);
    b = reshape(a,132,132);
    imshow(b);
    restore = min( restore, b);
end
figure(1); imshow(im);
figure(50); imshow(restore);
