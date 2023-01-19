function [] = Resol_Diffusion_MVF_1D_instationnaire(Points, Lx, xMin, x, dx, nx)

## Résolution de l'équation de la diffusion pure instationnaire en 1D :
## dT/dt = R*d^2U/dx^2
## Ici U représente la temperature, mais il peut en réalisté représenter d'autres grandeures.

%%%%%
##[Points, Lx, xMin] = DefGeometrie1D;

%%%%%
##[x, dx, nx] = Mesh_MVF_1D(Points, Lx, xMin);

%%%%%
tf = input('Durée de la simulation : ');
nt = input('Nb de pas de temps : ');
dt = tf/nt; % Taille de la maille selon X
t = 0:dt:tf; % Coordonées sur X des noeuds

%%%%%
TE = input('Température à l''Est : '); % CL en E
TW = input('Température à l''Ouest : '); % CL en W

% Conditions initiales
T0 = ones(nx,1)*input('Température initiale de la barre : '); % CI uniforme sur X;
T = zeros(nx, nt+1);
T(:,1) = T0(:);

R = input('Diffusivité thermique R en [m^2/s] (R = Lambda/(rho*c) : '); % Coef de diffusivité thermique [m^2/s] (R = Lambda/(rho*c))
Re = R;
Rw = R;

h = 1; % l'épaisseur est égale à l'unité
dy = 1; % la largeur est égale à l'unité
Ae = dy*h; % Section transversalle
Aw = dy*h; % Section transversalle

dxe = dx; % Distance entre les points X et E
dxw = dx; % Distance entre les points X et W

aE = Re*Ae/dxe; % Coef devant les thermes d'intérêts
aW = Rw*Aw/dxw; % Coef devant les thermes d'intérêts
aP0 = dx*dy*h/dt;
aP = aP0+aE+aW;

%%%%%
% Ecriture des 3 types d'équations
%      -----------------
%      |G |    C    |D |
%      -----------------

##eqa(G)  = -0+aP*T(i,t+1)-aE*T(i+1,t+1) = aW*TW+aP0*T(i,t)
##eqa(C)  = -aW*T(i-1,t+1)+aP*T(i,t+1)-aE*T(i+1,t+1) = aP0*T(i,t)
##eqa(D)  = -aW*T(i-1,t+1)+aP*T(i,t+1)-0 = aP0*T(i,t)+aE*TE

%%%%%
% Formation de la matrice [A]
disp('Formation de la matrice [A]...');
tic_A = tic;
A = zeros(nx, nx);

A(1,1) = aP;
A(1,2) = -aE;
for i=2:nx-1
  A(i,i-1) = -aW;
  A(i,i) = aP;
  A(i,i+1) = -aE;
endfor
A(nx,nx) = aP;
A(nx,nx-1) = -aW;

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
b = zeros(nx, nt);

for time = 2:1:nt+1
  % Formation de la matrice [b]
  b(1,time-1) = aW*TW+aP0*T(1,time-1);
  for i=2:nx-1
    b(i,time-1) = aP0*T(i,time-1);
  endfor
  b(nx,time-1) = aP0*T(nx,time-1)+aE*TE;
  
  % Résolution du système d'équation [A][T]=[b]
  T(:,time) = Ainv*b(:,time-1);
endfor
disp('Formation de la matrice [b] et résolution temporelle terminées.');
toc(tic_b_t)

%%%%%
% Conditions aux limites
TE = ones(1, nt+1)*TE;
TW = ones(1, nt+1)*TW;
TT = [TW; T; TE];
x = [0; x'; Lx];

figure(2)
plot(x,TT,'-*') % Tracé de la solution numérique
##ye = dsolve('0.5*D2y=0','y(0)=100','y(10)=500'); % Solution exacte
##hold on
##ezplot(ye,[0 10]) % Tracé de la solution exacte
xlabel('x')
ylabel('T')
title('Diffusion pure avec MVF')