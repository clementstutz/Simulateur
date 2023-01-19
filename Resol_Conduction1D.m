function [Resultat] = ResolConduction1D ()
  %% Résolution Numérique de l’Equation de la chaleur en régime stationaire %%
  %% cas simple: la lamelle 1D soumise à un choc thermique (sans source de chaleur volumique) %%
  
  %% Définition des conditions initiales et aux limites du problèm %%
  %CL :
  %CL_T_0_t = input(['Entrer une valeur pour la température de la barre à l''extrémité x = 0 pour tous temps t : ']);
  %CL_T_L_t = input(['Entrer une valeur pour la température de la barre à l''extrémité x = L pour tous temps t : ']);
  
  %% Définition des paramètre du problème %%
  L = input(['Entrer la longueur de la barre : ']);
  %l = 0.01;%input(['Entrer la profondeur de la barre : ']);
  %e = 0.001;%input(['Entrer l''épaisseur de la barre : ']);
  %p = 2*(l+e); %perimetre de l'ailette
  Nmax = input(['Entrer le nombre de points de calcul : ']);
  x = linspace(0, L, Nmax)'
  T = zeros(Nmax, 1);
  dx = L/(Nmax-1);
  T0 = 100;
  T1 = 20;
  a = (T1-T0)/L;

  % Résolution de l'equation de la chaleur dicretisee
  T(1) = T0;
  T(Nmax) = T1; 
  for i = 2:1:Nmax-1
    T(i) = a*x(i)+T0;
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
