function [] = Resol_Diffusion_MVF_2D(Points, Lx, xMin, Ly, yMin, x, dx, nx, y, dy, ny, Mesh, XX, YY)

## Résolution de l'équation de Laplace (ou de la diffusion pure stationnaire) en 2D :
## R*div(grad(U(x,y))) = 0
## Ici U représente la temperature, mais il peut en réalisté représenter d'autres grandeures.

%%%%%
##[Points, Lx, xMin, Ly, yMin] = DefGeometrie2D;

%%%%%
##[x, dx, nx, y, dy, ny, Mesh, XX, YY] = Mesh_MVF_2D(Points, Lx, xMin, Ly, yMin);
clear Mesh;
clear XX;
clear YY;

%%%%%
TE = input('Température à l''Est : '); % CL en E
TW = input('Température à l''Ouest : '); % CL en W
TN = input('Température au Nord : '); % CL en N
TS = input('Température au Sud : '); % CL en S

R = input('Diffusivité thermique R en [m^2/s] (R = Lambda/(rho*c) : '); % Coef de diffusivité thermique [m^2/s] (R = Lambda/(rho*c))
Re = R;
Rw = R;
Rn = R;
Rs = R;

h = 1; % l'épaisseur est égale à l'unité
Ae = dy*h; % Section transversalle
Aw = dy*h;
An = dx*h; % Section transversalle
As = dx*h;

dxe = dx; % Distance entre les points X et E
dxw = dx; % Distance entre les points X et W
dxn = dy; % Distance entre les points X et N
dxs = dy; % Distance entre les points X et S

aEW = Re*Ae/dxe; % Coef devant les thermes d'intérêts
aW = Rw*Aw/dxw; % Coef devant les thermes d'intérêts
aNS = Rn*An/dxn; % Coef devant les thermes d'intérêts
aS = Rs*As/dxs; % Coef devant les thermes d'intérêts

%%%%%
% Ecriture des 9 types d'équations
%      -----------------
%      |HG|    H    |HD|
%      -----------------
%      |  |         |  |
%      |G |    C    |D |
%      |  |         |  |
%      -----------------
%      |BG|    B    |BD|
%      -----------------

##eqa(BG) = 0 + 0 - (2*aS+2*aW+aE+aN)*T(i,j) + aE*T(i+1,j) + aN*T(i,j+1) = - 2*aS*TS - 2*aW*TW
##eqa(B)  = 0 + aW*T(i-1,j) - (2*aS+aW+aE+aN)*T(i,j) + aE*T(i+1,j) + aN*T(i,j+1) = - 2*aS*TS
##eqa(BD) = 0 + aW*T(i-1,j) - (2*aS+aW+2*aE+aN)*T(i,j) + 0 + aN*T(i,j+1) = - 2*aS*TS - 2*aE*TE
##eqa(G)  = aS*T(i,j-1) + 0 - (aS+2*aW+aE+aN)*T(i,j) + aE*T(i+1,j) + aN*T(i,j+1) = - 2*aW*TW
##eqa(C)  = aS*T(i,j-1) + aW*T(i-1,j) - (aS+aW+aE+aN)*T(i,j) + aE*T(i+1,j) + aN*T(i,j+1) = 0
##eqa(D)  = aS*T(i,j-1) + aW*T(i-1,j) - (aS+aW+2*aE+aN)*T(i,j) + 0 + aN*T(i,j+1) = - 2*aE*TE
##eqa(HG) = aS*T(i,j-1) + 0 - (aS+2*aW+aE+2*aN)*T(i,j) + aE*T(i+1,j) + 0 = - 2*aW*TW - 2*aN*TN
##eqa(H)  = aS*T(i,j-1) + aW*T(i-1,j) - (aS+aW+aE+2*aN)*T(i,j) + aE*T(i+1,j) + 0 = - 2*aN*TN
##eqa(HD) = aS*T(i,j-1) + aW*T(i-1,j) - (aS+aW+2*aE+2*aN)*T(i,j) + 0 + 0 = - 2*aE*TE - 2*aN*TN

% Formation des matrices [A] et [b]
disp('Formation des matrices [A] et [b]...');
tic_Ab = tic;
A = zeros(nx*ny, nx*ny);
b = zeros(nx*ny, 1);

% BG
BG = zeros(nx*ny,1);
BG(1) = -(3*aEW+3*aNS);
BG(2) = aEW;
BG(nx+1) = aNS;

A(1,:) = BG(:);
clear BG;
b(1,1) = -2*aEW*TW-2*aNS*TS;

% B
B = zeros(nx*ny,1);
B(1) = aEW;
B(2) = -(2*aEW+3*aNS);
B(3) = aEW;
B(nx+2) = aNS;

k = 0;
for i = 2:1:nx-1
  A(i,:) = TranslatVector(B, k);
  k = k-1;
  b(i,1) = -2*aNS*TS;
endfor
clear B;

% BD
BD = zeros(nx*ny,1);
translat = nx-2;
BD(1+translat) = aEW;
BD(2+translat) = -(3*aEW+3*aNS);
BD(nx+2+translat) = aNS;

A(nx,:) = BD(:);
clear BD;
b(nx,1) = -2*aEW*TE-2*aNS*TS;

% G
G = zeros(nx*ny,1);
G(1) = aNS;
G(nx+1) = -(3*aEW+2*aNS);
G(nx+2) = aEW;
G(2*nx+1) = aNS;

k = 0;
for j = 2:1:ny-1
  A((j-1)*nx+1,:) = TranslatVector(G, k);
  k = k-nx;
  b((j-1)*nx+1,1) = -2*aEW*TW;
endfor
clear G;

% C
C = zeros(nx*ny,1);
translat = 1;
C(1+translat) = aNS;
C(nx+translat) = aEW;
C(nx+1+translat) = -(2*aEW+2*aNS);
C(nx+2+translat) = aEW;
C(2*nx+1+translat) = aNS;

k = 0;
for j = 2:1:ny-1
  for i = (j-1)*nx+2:1:j*nx-1
    A(i,:) = TranslatVector(C, k);
    k = k-1;
    b(i,1) = 0;
  endfor
  k = k-2;
endfor
clear C;

% D
D= zeros(nx*ny,1);
translat = nx-1;
D(1+translat) = aNS;
D(nx+translat) = aEW;
D(nx+1+translat) = -(3*aEW+2*aNS);
D(2*nx+1+translat) = aNS;

k = 0;
for j = 2:1:ny-1
  A(j*nx,:) = TranslatVector(D, k);
  k = k-nx;
  b(j*nx,1) = -2*aEW*TE;
endfor
clear D;

% HG
HG = zeros(nx*ny,1);
translat = nx*(ny-2);
HG(1+translat) = aNS;
HG(nx+1+translat) = -(3*aEW+3*aNS);
HG(nx+2+translat) = aEW;

A(nx*(ny-1)+1,:) = HG(:);
clear HG;
b(nx*(ny-1)+1,1) = -2*aEW*TW-2*aNS*TN;

% H
H = zeros(nx*ny,1);
translat = nx*(ny-2)+1;
H(1+translat) = aNS;
H(nx+translat) = aEW;
H(nx+1+translat) = -(2*aEW+3*aNS);
H(nx+2+translat) = aEW;

k = 0;
for i = nx*(ny-1)+2:1:nx*ny-1
  A(i,:) = TranslatVector(H, k);
  k = k-1;
  b(i,1) = -2*aNS*TN;
endfor
clear H;

% HD
HD = zeros(nx*ny,1);
translat = nx*(ny-1)-1;
HD(1+translat) = aNS;
HD(nx+translat) = aEW;
HD(nx+1+translat) = -(3*aEW+3*aNS);

A(nx*ny,:) = HD(:);
clear HD;
b(nx*ny,1) = -2*aEW*TE-2*aNS*TN;

disp('Formation des matrices [A] et [b] terminée');
toc(tic_Ab)

% Résolution du système linéaire
disp('Inversion de [A]...');
tic_invA = tic;
Ainv = inv(A);
fprintf('Inversion de [A] terminée. (%f s) \n', toc(tic_invA))

disp('Calcul de T...');
tic_T = tic;
T = Ainv*b;
fprintf('Calcul de T terminé. (%f s) \n', toc(tic_T))

% Post-traitement pour affichage des données
disp('Post-traitement de T');
tic_post = tic;
TT = zeros(ny,nx);

k=1;
for j = 1:1:ny
  for i = 1:1:nx
    TT(j,i) = T(k);
    k=k+1;
  endfor
endfor
fprintf('Post-traitement de T terminé. (%f s) \n', toc(tic_post))

% Conditions aux limites /!\ Attention cela fausse les resultats tel qu'il est implémenté !
##for j = 1:1:ny
##  TT(j,nx) = TE;
##endfor
##
##for j = 1:1:ny
##  TT(j,1) = TW;
##endfor
##
##for i = 1:1:nx
##  TT(ny,i) = TN;
##endfor
##
##for i = 1:1:nx
##  TT(1,i) = TS;
##endfor

figure(2)
surf(x, y, TT)
colorbar
shading('flat') % interpolation de couleur
colormap(jet)
ylabel('Y');xlabel('X');zlabel('T');title('Temperature')

disp('Fin Diffusion_MVF_2D');