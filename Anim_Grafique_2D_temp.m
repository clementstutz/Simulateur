function [] = Anim_Grafique_2D_temp(nom_video, nb_frames, x, y, XX, YY, TT, axes, fps, GraphInfo)
  % Génère un fichier .mpa qu'une animation d'un graphique 2D en fonction du temps.
  
% Octave: chargement package "video" pour fonctions "avifile" et "addframe"
  if exist('OCTAVE_VERSION')  % pour Octave
    pkg load video
  end

% Creation/ouverture du fichier video, ouverture fenetre figure vide
##  nom_video = 'animation.mp4';
  if exist('OCTAVE_VERSION')  % pour Octave
    fich_video = avifile(nom_video,'codec','mpeg4','fps', fps);  % sous Windows
  else                        % pour MATLAB
    fich_video = VideoWriter(nom_video,'MPEG-4');
    open(fich_video)
  end
  fig=figure;     % ouverture fenetre figure vide
  colormap(jet)
   
% Parametres du graphique   
##  nb_frames=50;          % nb frames animation
##  x=0:0.2:2*pi;  y=x;    % plage de valeurs en X et Y
##  [XX,YY]=meshgrid(x,y); % matrices grille X/Y

% Boucle de dessin des frames et insertion dans la video
  fprintf('Frames # ')
  for n=1:nb_frames;
    fprintf('%d ',n)  % indicateur de progression: numero du frame)
##    z=cos(XX).*sin(YY).*sin(2*pi*n/nb_frames);
    surf(x,y,TT(:,:,n))                    % affichage n-ième image
    colorbar
    shading('flat') % interpolation de couleur
    colormap(jet)
    title(GraphInfo(1,:)); xlabel(GraphInfo(2,:)); ylabel(GraphInfo(3,:)); zlabel(GraphInfo(4,:));
##    azimut=mod(45+(360*n/nb_frames),360);  % azimut modulo 360 degres
##    view(azimut, 30)               % changement azimut vue
    axis = axes;     % cadrage axes
##    axis('off')
    img_frame = getframe(fig);     % recuperation frame
    if exist('OCTAVE_VERSION')     % pour Octave
      norm_frame = single(img_frame.cdata)/255 ;
        % normalisation des valeurs: uint8 [0 à 255] -> real-single [0 à 1]
      addframe(fich_video, norm_frame);    % insertion frame
    else                           % pour MATLAB
      writeVideo(fich_video, img_frame); % insertion frame
    end
  end

% Fermeture fichier video et fenetre figure
  if exist('OCTAVE_VERSION')  % pour Octave
    clear fich_video
  else                        % pour MATLAB
    close(fich_video)
  end
##  close(fig)
  fprintf('\nLa video est assemblee dans le fichier "%s" !\n', nom_video)