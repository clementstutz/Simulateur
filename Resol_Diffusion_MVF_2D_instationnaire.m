function [] = Resol_Diffusion_MVF_2D_instationnaire(Points, Lx, xMin, Ly, yMin, x, dx, nx, y, dy, ny, Mesh, XX, YY)

## Résolution de l'équation de la diffusion pure instationnaire en 2D :
## dT/dt = R*div(grad(U(x,y)))
## Ici U représente la temperature, mais il peut en réalisté représenter d'autres grandeures.

%%%%%
##[Points, Lx, xMin, Ly, yMin] = DefGeometrie2D;

%%%%%
##[x, dx, nx, y, dy, ny, Mesh, XX, YY] = Mesh_MVF_2D(Points, Lx, xMin, Ly, yMin);
clear Mesh;
##clear XX;
##clear YY;

%%%%%
tf = input('Durée de la simulation : ');
nt = input('Nb de pas de temps : ');
dt = tf/nt; % Taille de la maille selon X
t = 0:dt:tf; % Coordonées sur X des noeuds

%%%%%
TE = ones(ny,1)*input('Température à l''Est : '); % CL en E
TW = ones(ny,1)*input('Température à l''Ouest : '); % CL en W
TN = ones(nx,1)*input('Température au Nord : '); % CL en N
TS = ones(nx,1)*input('Température au Sud : '); % CL en S

% Conditions initiales
T0 = ones(nx*ny,1)*input('Température initiale de la surface : '); % CI uniforme sur XY;
T = zeros(nx*ny, nt+1);
T(:,1) = T0(:);

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

aE = Re*Ae/dxe; % Coef devant les thermes d'intérêts
aW = Rw*Aw/dxw; % Coef devant les thermes d'intérêts
aN = Rn*An/dxn; % Coef devant les thermes d'intérêts
aS = Rs*As/dxs; % Coef devant les thermes d'intérêts
aP0 = dx*dy*h/dt;
aP = aP0+aE+aW+aN+aS;

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

##eqa(BG) = -0-0+aP*T(i,j,t+1)-aE*T(i+1,j,t+1)-aN*T(i,j+1,t+1) = aS*TS(i)+aW*TW(j)+aP0*T(i,j,t)
##eqa(B)  = -0-aW*T(i-1,j,t+1)+aP*T(i,j,t+1)-aE*T(i+1,j,t+1)-aN*T(i,j+1,t+1) = aS*TS(i)+aP0*T(i,j,t)
##eqa(BD) = -0-aW*T(i-1,j,t+1)+aP*T(i,j,t+1)-0-aN*T(i,j+1,t+1) = aS*TS(i)+aP0*T(i,j,t)+aE*TE(j)
##eqa(G)  = -aS*T(i,j-1,t+1)-0+aP*T(i,j,t+1)-aE*T(i+1,j,t+1)-aN*T(i,j+1,t+1) = aW*TW(j)+aP0*T(i,j,t)
##eqa(C)  = -aS*T(i,j-1,t+1)-aW*T(i-1,j,t+1)+aP*T(i,j,t+1)-aE*T(i+1,j,t+1)-aN*T(i,j+1,t+1) = aP0*T(i,j,t)
##eqa(D)  = -aS*T(i,j-1,t+1)-aW*T(i-1,j,t+1)+aP*T(i,j,t+1)-0-aN*T(i,j+1,t+1) = aP0*T(i,j,t)+aE*TE(j)
##eqa(HG) = -aS*T(i,j-1,t+1)-0+aP*T(i,j,t+1)-aE*T(i+1,j,t+1)-0 = aW*TW(j)+aP0*T(i,j,t)+aN*TN(i)
##eqa(H)  = -aS*T(i,j-1,t+1)-aW*T(i-1,j,t+1)+aP*T(i,j,t+1)-aE*T(i+1,j,t+1)-0 = aP0*T(i,j,t)+aN*TN(i)
##eqa(HD) = -aS*T(i,j-1,t+1)-aW*T(i-1,j,t+1)+aP*T(i,j,t+1)-0-0 = aP0*T(i,j,t)+aE*TE(j)+aN*TN(i)

% Formation de la matrice [A]
disp('Formation de la matrice [A]...');
tic_A = tic;
A = zeros(nx*ny, nx*ny);

% BG
BG = zeros(nx*ny,1);
BG(1) = aP;
BG(2) = -aE;
BG(nx+1) = -aN;

A(1,:) = BG(:);
clear BG;

% B
B = zeros(nx*ny,1);
B(1) = -aW;
B(2) = aP;
B(3) = -aE;
B(nx+2) = -aN;

k = 0;
for i = 2:1:nx-1
  A(i,:) = TranslatVector(B, k);
  k = k-1;
endfor
clear B;

% BD
BD = zeros(nx*ny,1);
translat = nx-2;
BD(1+translat) = -aW;
BD(2+translat) = aP;
BD(nx+2+translat) = -aN;

A(nx,:) = BD(:);
clear BD;

% G
G = zeros(nx*ny,1);
G(1) = -aS;
G(nx+1) = aP;
G(nx+2) = -aE;
G(2*nx+1) = -aN;

k = 0;
for j = 2:1:ny-1
  A((j-1)*nx+1,:) = TranslatVector(G, k);
  k = k-nx;
endfor
clear G;

% C
C = zeros(nx*ny,1);
translat = 1;
C(1+translat) = -aS;
C(nx+translat) = -aW;
C(nx+1+translat) = aP;
C(nx+2+translat) = -aE;
C(2*nx+1+translat) = -aN;

k = 0;
for j = 2:1:ny-1
  for i = (j-1)*nx+2:1:j*nx-1
    A(i,:) = TranslatVector(C, k);
    k = k-1;
  endfor
  k = k-2;
endfor
clear C;

% D
D= zeros(nx*ny,1);
translat = nx-1;
D(1+translat) = -aS;
D(nx+translat) = -aW;
D(nx+1+translat) = aP;
D(2*nx+1+translat) = -aN;

k = 0;
for j = 2:1:ny-1
  A(j*nx,:) = TranslatVector(D, k);
  k = k-nx;
endfor
clear D;

% HG
HG = zeros(nx*ny,1);
translat = nx*(ny-2);
HG(1+translat) = -aS;
HG(nx+1+translat) = aP;
HG(nx+2+translat) = -aE;

A(nx*(ny-1)+1,:) = HG(:);
clear HG;

% H
H = zeros(nx*ny,1);
translat = nx*(ny-2)+1;
H(1+translat) = -aS;
H(nx+translat) = -aW;
H(nx+1+translat) = aP;
H(nx+2+translat) = -aE;

k = 0;
for i = nx*(ny-1)+2:1:nx*ny-1
  A(i,:) = TranslatVector(H, k);
  k = k-1;
endfor
clear H;

% HD
HD = zeros(nx*ny,1);
translat = nx*(ny-1)-1;
HD(1+translat) = -aS;
HD(nx+translat) = -aW;
HD(nx+1+translat) = aP;

A(nx*ny,:) = HD(:);
clear HD;

disp('Formation de la matrice [A] trerminée.');
toc(tic_A)

disp('Inversion de A...');
tic_invA = tic;
Ainv = inv(A);
disp('Inversion de A terminée');
toc(tic_invA)

% Formation de la matrice [b]
disp('Formation de la matrice [b] et résolution temporelle...');
tic_b_t = tic;
b = zeros(nx*ny, nt);

for time = 2:1:nt+1
  % Formation de la matrice [b]
  % BG
  b(1,time-1) = aS*TS(1)+aW*TW(1)+aP0*T(1,time-1);

  % B
  for i = 2:1:nx-1
    b(i,time-1) = aS*TS(i)+aP0*T(i,time-1);
  endfor

  % BD
  b(nx,time-1) = aS*TS(nx)+aP0*T(nx,time-1)+aE*TE(1);

  % G
  for j = 2:1:ny-1
    b((j-1)*nx+1,time-1) = aW*TW(j)+aP0*T((j-1)*nx+1,time-1);
  endfor

  % C
  for j = 2:1:ny-1
    for i = 2:1:nx-1
      b((j-1)*nx+i,time-1) = aP0*T((j-1)*nx+i,time-1);
    endfor
  endfor

  % D
  for j = 2:1:ny-1
    b(j*nx,time-1) = aP0*T(j*nx,time-1)+aE*TE(j);
  endfor

  % HG
  b(nx*(ny-1)+1,time-1) = aW*TW(ny)+aP0*T(nx*(ny-1)+1,time-1)+aN*TN(1);

  % H
  for i = 2:1:nx-1
    b((ny-1)*nx+i,time-1) = aP0*T((ny-1)*nx+i,time-1)+aN*TN(i);
  endfor

  % HD
  b(nx*ny,time-1) = aP0*T(nx*ny,time-1)+aE*TE(ny)+aN*TN(nx);
  
  % Résolution du système d'équation [A][T]=[b]
  T(:,time) = Ainv*b(:,time-1);
endfor
disp('Formation de la matrice [b] et résolution temporelle terminées.');
toc(tic_b_t)

% Poste traitement pour affichage des données
disp('Post-traitement de T');
tic_post = tic;
TT = zeros(ny,nx,nt+1);
k=1;
for j = 1:1:ny
  for i = 1:1:nx
    TT(j,i,:) = T(k,:);
    k=k+1;
  endfor
endfor
disp('Post-traitement de T terminé');
toc(tic_post)

% Conditions aux limites /!\ Attention cela fausse les resultats tel qu'il est implémenté !
##for time = 1:nt+1
##  for j = 1:1:ny
##    TT(j, nx, time) = TE(j);
##  endfor
##  
##  for j = 1:1:ny
##    TT(j, 1, time) = TW(j);
##  endfor
##  
##  for i = 1:1:nx
##    TT(ny, i, time) = TN(i);
##  endfor
##  
##  for i = 1:1:nx
##    TT(1, i, time) = TS(i);
##  endfor
##endfor

nom_video = 'DIffusion_MVF_2D_instationnaire.mp4';
nb_frames = nt+1;
axes = [xMin xMin+Lx yMin yMin+Ly min(min(min(TT(:,:,:)))) max(max(max(TT(:,:,:))))];
fps = floor((nt+1)/10);
GraphTitle = 'Temperature(t)';
Xlab = 'X';
Ylab = 'Y';
Zlab = 'T';
GraphInfo = [GraphTitle; Xlab; Ylab; Zlab];
Anim_Grafique_2D_temp(nom_video, nb_frames, x, y, XX, YY, TT, axes, fps, GraphInfo)

##figure(2)
##surf(x, y, TT(:,:,:))
##colorbar
##shading('flat') % interpolation de couleur
##colormap(hot)
##ylabel('Y');xlabel('X');zlabel('T');title('Temperature')

disp('Fin Diffusion_MVF_2D');