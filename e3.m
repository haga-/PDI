% Érick Moreira, Heitor Almeida, Matheus Neiverth
% Exercício 3

close all;
clear all;
clc;

pkg load image

hill = imread("hill.tif");

% a)
subplot(2,3,1), imshow(hill), title('Imagem Original');

% b), construindo o padding
hill_pad = padarray(hill, size(hill), "symmetric");
hill_pad_fq = fftshift(fft2(hill_pad));


% c)
subplot(2,3,2), imshow(real(hill_pad_fq)), title('Espectro Fourier');

% tentativa da d)
[U, V] = dftuv(size(hill)(1),size(hill)(2));

% Compute the distances D(U, V).
D = sqrt(U.^2 + V.^2);


%for x = size(hill_pad_fq)(1)
  %for y = size(hill_pad_fq)(2)
    %hill_pad_fq(x,y) = (1.5 - 0.5) * (1 - e^(-2 * (D^2*(hill_pad_fq(x,y))/2))) + 0.5;
  %endfor
%endfor

%imshow(ifft2(ifftshift(hill_pad_fq)))
  
