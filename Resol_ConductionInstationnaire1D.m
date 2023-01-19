function [Resultat] = Resol_ConductionInstationnaire1D ()
  %% R�solution Num�rique de l�Equation de la chaleur en r�gime instationnaire %%
  %% cas simple: la lamelle 1D soumise � un choc thermique (sans source de chaleur volumique) %%
  
  %% D�finition des conditions initiales et aux limites du probl�m %%
  %CI :
  CI_T_x_t0 = input(['Entrer une valeur pour la temp�rature de la barre � l''instant initial t0 : ']);
  %CL :
  CL_T_0_t = input(['Entrer une valeur pour la temp�rature de la barre � l''extr�mit� x = 0 pour tous temps t : ']);
  CL_T_L_t = input(['Entrer une valeur pour la temp�rature de la barre � l''extr�mit� x = L pour tous temps t : ']);
  
  %% D�finition des param�tre du probl�me %%
  L = input(['Entrer la longueur de la barre : ']);
  Nmax = input(['Entrer le nombre de points de calcul : ']);
  x = linspace(0, L, Nmax)';
  T = zeros(Nmax, 1);
  Tn = zeros(Nmax, 1);
  dx = L/(Nmax-1);
  t0 = 0;
  tMax = input(['Entrer le temps qui doit �tre simul� : ']);
  
  %% Discr�tisation temporelle %%
  choice = menu('Faites un choix', 'Calcul rapide', 'Pas de temps personalis�');
  if choice == 1
    dt = dx^2/2;
  else
    dt = dx^2/2+1;
    while dt > dx^2/2
      dt = input(['Entrer une valeur inf�rieure � ' num2str(dx^2/2) ' pour le pas de temps : ']);
    end
  end
  
  %% Initialisation avec les conditions initiales du probl�m %%
  for i = 1:1:Nmax
    T(i) = CI_T_x_t0;
    Tn(i) = CI_T_x_t0;
  end
  
  % On avance en temps avec la boucle, et a chaque temps, on r�soud en espace
  disp('Avancement de la r�solution : ');
  itMax = tMax/dt;
  step = 1;
  progression = step;
  for it = 1:1:itMax
    t0 = t0+dt;
    T(1) = CL_T_0_t; % On force les conditions aux limites
    T(Nmax) = CL_T_L_t;
    Tn(1) = CL_T_0_t;
    Tn(Nmax) = CL_T_L_t;
    
    % R�solution de l'equation de la chaleur dicretisee
    for i = 2:1:Nmax-1
      Tn(i)=T(i)+(dt/dx/dx)*(T(i+1)-2*T(i)+T(i-1));
    end
    
    % On �swape� les tableaux, T devient Tn
    for i = 1:1:Nmax
      T(i) = Tn(i); % La nouvelle temp�rature devient l'ancienne
    end
    
    % Progression de la simulation
    progression = ProgressionDuCalcul (it, itMax, step, progression);
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