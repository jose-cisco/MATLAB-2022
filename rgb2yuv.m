% 'RGB CONVERT TO YUV'
R = input('Please input the R');
G = input('Please input the G');
B = input('Please input the B');

Y = 0.3*R+0.6*G+0.1*B;
U = B-Y;
V = R-Y;

fprintf('RGB = (%d,%d,%d)\n',R,G,B );
fprintf('YUV = (%.2f,%.2f,%.2f)\n',Y,U,V );