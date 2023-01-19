function [] = Resol_Diffusion_MVF_1D(Points, Lx, xMin, x, dx, nx)

## Résolution de l'équation de Laplace (ou de la diffusion pure stationnaire) en 1D :
## R*d^2U/dx^2 = 0
## Ici U représente la temperature, mais il peut en réalisté représenter d'autres grandeures.

%%%%%
##[Points, Lx, xMin] = DefGeometrie1D;

%%%%%
##[x, dx, nx] = Mesh_MVF_1D(Points, Lx, xMin);

%%%%%
TE = input('Température à l''Est : '); % CL en E
TW = input('Température à l''Ouest : '); % CL en W

R = input('Diffusivité thermique R en [m^2/s] (R = Lambda/(rho*c) : '); % Coef de diffusivité thermique [m^2/s] (R = Lambda/(rho*c))
Re = R;
Rw = R;

##A = 0.05; %input('Section transversalle de la géométrie : '); % Section transversalle
h = 1; % l'épaisseur est égale à l'unité
dy = 1; % la largeur est égale à l'unité
Ae = dy*h; % Section transversalle
Aw = dy*h;

dxe = dx; % Distance entre les points X et E
dxw = dx; % Distance entre les points X et W

aE = Re*Ae/dxe; % Coef devant les thermes d'intérêts
aW = Rw*Aw/dxw; % Coef devant les thermes d'intérêts

%%%%%
% Ecriture des 3 types d'équations
%      -----------------
%      |G |    C    |D |
%      -----------------

##eqa(G)  = 0 - (2*aW+aE)*T(1) + aE*T(2) = - 2*aW*TW
##eqa(C)  = aW*T(i-1) - (aW+aE)*T(i) + aE*T(i+1) = 0
##eqa(D)  = aW*T(nx-1) - (aW+2*aE)*T(nx) + 0 = - 2*aE*TE

%%%%%
% Formation de la matrice [A]
A(1,1) = -(2*aW+aE);
A(1,2) = aE;
for i=2:nx-1
  A(i,i-1) = aW;
  A(i,i) = -(aW+aE);
  A(i,i+1) = aE;
endfor
A(nx,nx-1) = aW;
A(nx,nx) = -(aW+2*aE);

% Formation du vecteur [b]
b(1) = -2*aW*TW;
b(nx) = -2*aE*TE;

%%%%%
% Résolution du système d'équation [A][T]=[b]
T=A\b';

%%%%%
% Présentation et comparaison avec la solution exacte
T = [TW; T; TE];
x = [0; x'; Lx];

figure(2)
plot(x,T,'-*') % Tracé de la solution numérique
##ye = dsolve('0.5*D2y=0','y(0)=100','y(10)=500'); % Solution exacte
##hold on
##ezplot(ye,[0 10]) % Tracé de la solution exacte
xlabel('x')
ylabel('T')
title('Diffusion pure avec MVF')

endfunction