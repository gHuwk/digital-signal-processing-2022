 pkg load image;
 
 I = double(imread('/home/tanaka/gits/digital-signal-processing-2022/lab09/bimage5.bmp')) / 255;

 figure, imshow (I);
 title ("Original image");

 PSF=fspecial('motion', 10, 205);

 J = deconvwnr (I, PSF);%, psf, estimated_nsr);
 
 figure, imshow (J)
 title ({"restored image after deconvolution",
           "with known PSF"});