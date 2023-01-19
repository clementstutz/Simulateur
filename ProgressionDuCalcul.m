function [progression] = ProgressionDuCalcul (currentIteration, iterationMax, step, progression)
  
  if currentIteration/iterationMax >= progression/100
    disp([num2str(round(currentIteration/iterationMax*100)) '%'])
    progression = progression+step;
  else
    progression = progression;
  end
  
endfunction
