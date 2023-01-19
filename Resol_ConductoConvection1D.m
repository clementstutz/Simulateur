function [Resultat] = ResolConductoConvection1D ()
  %% R�solution Num�rique de l�Equation de la conduction thermique coupl� avec de la convection%%
  %% cas simple: ailette de refroidissement � 1D soumise � une source de chaleur et plong�e dans un thermostat %%
  
  %% D�finition des conditions initiales et aux limites du probl�m %%
  %CL :
  %CL_T_0_t = input(['Entrer une valeur pour la temp�rature de la barre � l''extr�mit� x = 0 pour tous temps t : ']);
  %CL_T_L_t = input(['Entrer une valeur pour la temp�rature de la barre � l''extr�mit� x = L pour tous temps t : ']);
  
  %% D�finition des param�tre du probl�me %%
  L = input(['Entrer la longueur de la barre : ']);
  l = 0.01;%input(['Entrer la profondeur de la barre : ']);
  e = 0.001;%input(['Entrer l''�paisseur de la barre : ']);
  R = 0.004;
  %p = 2*(l+e); % Perimetre de l'ailette
  %S = l*e;  % Section de l'ailette
  p = 2*pi*R; % Perimetre de l'ailette
  S = pi*R^2;  % Section de l'ailette
  Nmax = input(['Entrer le nombre de points de calcul : ']);
  x = linspace(0, L, Nmax)';
  T = zeros(Nmax, 1);
  dx = L/(Nmax-1);
  T0 = 100;
  T1= 20;
  Ta = 20;
  k = 200;%input(['Entrer la conductivit� thermique du materiau de la barre : ']);.
  h = 10;%input(['Entrer le coef de convextion thermique entre la barre et l'environnement : ']);

  % R�solution de l'equation de la chaleur dicretisee
  T(1) = T0;
  T(Nmax) = T1;
  %%c1 + c2 + Ta = T0
  %%c1*exp(sqrt(h*p/(k*S))*L) + c2*exp(-sqrt(h*p/(k*S))*L) + Ta = T1
    %%c1 + c2 + Ta = T0
    %%c1 + (c2*exp(-sqrt(h*p/(k*S))*L) + Ta)/exp(sqrt(h*p/(k*S))*L) = T1/exp(sqrt(h*p/(k*S))*L)
      %%c2 + Ta - (c2*exp(-sqrt(h*p/(k*S))*L) + Ta)/exp(sqrt(h*p/(k*S))*L) = T0 - T1/exp(sqrt(h*p/(k*S))*L)
      %%c1 + (c2*exp(-sqrt(h*p/(k*S))*L) + Ta)/exp(sqrt(h*p/(k*S))*L) = T1/exp(sqrt(h*p/(k*S))*L)
        %%c2 * (1 -exp(-sqrt(h*p/(k*S))*L)/exp(sqrt(h*p/(k*S))*L)) + Ta = T0 - T1/exp(sqrt(h*p/(k*S))*L)
        %%c1 + (c2*exp(-sqrt(h*p/(k*S))*L) + Ta)/exp(sqrt(h*p/(k*S))*L) = T1/exp(sqrt(h*p/(k*S))*L)
          %%c2 = (T0 - T1/exp(sqrt(h*p/(k*S))*L) - Ta)/(1 -exp(-sqrt(h*p/(k*S))*L)/exp(sqrt(h*p/(k*S))*L))
          %%c1 + (c2*exp(-sqrt(h*p/(k*S))*L) + Ta)/exp(sqrt(h*p/(k*S))*L) = T1/exp(sqrt(h*p/(k*S))*L)
            c2 = (T0 - T1/exp(sqrt(h*p/(k*S))*L) - Ta)/(1 -exp(-sqrt(h*p/(k*S))*L)/exp(sqrt(h*p/(k*S))*L));
            c1 = T1/exp(sqrt(h*p/(k*S))*L) - (((T0 - T1/exp(sqrt(h*p/(k*S))*L) - Ta)/(1 -exp(-sqrt(h*p/(k*S))*L)/exp(sqrt(h*p/(k*S))*L)))*exp(-sqrt(h*p/(k*S))*L) + Ta)/exp(sqrt(h*p/(k*S))*L);
    
  for i = 2:1:Nmax-1
    T(i) = Ta + c1*exp(sqrt(h*p/(k*S))*x(i)) +c2*exp(-sqrt(h*p/(k*S))*x(i));
  end
  
  figure(1)
    subplot(2,1,1)
      plot(x, T, 'm-');

    subplot(2,1,2)
      y = linspace(0, 1, 2);
      TT(1,:) = T;
      TT(2,:) = T;
      TT;
      pcolor(x,y,TT)
      shading('interp') % interpolation de couleur
      colormap(hot)     % changement table couleurs
      colorbar
  
endfunction
