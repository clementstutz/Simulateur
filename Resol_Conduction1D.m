function [Resultat] = ResolConduction1D ()
  %% R�solution Num�rique de l�Equation de la chaleur en r�gime stationaire %%
  %% cas simple: la lamelle 1D soumise � un choc thermique (sans source de chaleur volumique) %%
  
  %% D�finition des conditions initiales et aux limites du probl�m %%
  %CL :
  %CL_T_0_t = input(['Entrer une valeur pour la temp�rature de la barre � l''extr�mit� x = 0 pour tous temps t : ']);
  %CL_T_L_t = input(['Entrer une valeur pour la temp�rature de la barre � l''extr�mit� x = L pour tous temps t : ']);
  
  %% D�finition des param�tre du probl�me %%
  L = input(['Entrer la longueur de la barre : ']);
  %l = 0.01;%input(['Entrer la profondeur de la barre : ']);
  %e = 0.001;%input(['Entrer l''�paisseur de la barre : ']);
  %p = 2*(l+e); %perimetre de l'ailette
  Nmax = input(['Entrer le nombre de points de calcul : ']);
  x = linspace(0, L, Nmax)'
  T = zeros(Nmax, 1);
  dx = L/(Nmax-1);
  T0 = 100;
  T1 = 20;
  a = (T1-T0)/L;

  % R�solution de l'equation de la chaleur dicretisee
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
