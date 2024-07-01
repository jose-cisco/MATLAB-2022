function [Y,U,V] = rgbctyuv(R,G,B)
Y = 0.3*R+0.6*G+0.1*B;
U = B-Y;
V = R-Y;
fprintf('YUV = (%.2f,%.2f,%.2f)\n',Y,U,V );