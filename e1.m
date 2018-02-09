% Érick Moreira, Heitor Almeida, Matheus Neiverth
% Exercício 1

close all;
clear all;
clc;

pkg load image;

% Imagem original
head = imread('head_CT.tif');

%Determine good padding for Fourier transform
PQ = paddedsize(size(head));

%Create Notch filters corresponding to extra peaks in the Fourier transform
H1 = notch('ideal', PQ(1), PQ(2), 10, 80, 80);
H2 = notch('ideal', PQ(1), PQ(2), 10, -80, -80);

% Calculate the discrete Fourier transform of the image
F = fft2(double(head),PQ(1),PQ(2));

% Apply the notch filters to the Fourier spectrum of the image
FS_head = F.*H1.*H2;
FS_head = FS_head.*H1.*H2;

% convert the result to the spacial domain.
F_head = real(ifft2(FS_head));

% Crop the image to undo padding
F_head = F_head(1:size(head,1), 1:size(head,2));

%Display the blurred image
%figure, imshow(F_head,[])

% Display the Fourier Spectrum
% Move the origin of the transform to the center of the frequency rectangle.
Fc  = fftshift(F);
Fcf = fftshift(FS_head);

% use abs to compute the magnitude and use log to brighten display
S1 = log(1+abs(Fc));
S2 = log(1+abs(Fcf));
%figure, imshow(S1,[])
%figure, imshow(S2,[])

figure, imshow(head);
%figure, imshow(FS_head, []);
figure, imshow(F_head, []);
