function [V] = TranslatVector(V, k)
% Translate un vecteur sur lui même de k éléments (comme les roues d'une machine à sous).

if k > 0
  V1 = zeros(k,1);
  
  for i = 1:k
    V1(i) = V(i);
  endfor

  for i = 1:length(V)-k
    V(i) = V(i+k);
  endfor

  for i = length(V)-k+1:length(V)
    V(i) = V1(i-length(V)+k);
  endfor
  
elseif k < 0
  k2 = sqrt(k*k);
  V1 = zeros(k2,1);
  
  for i = length(V)-k2+1:length(V)
    V1(i-(length(V)-k2+1)+1) = V(i);
  endfor

  for i = length(V):-1:k2+1
    V(i) = V(i-k2);
  endfor

  for i = 1:k2
    V(i) = V1(i);
  endfor

endif

endfunction