load('trialResion.mat');

isRIGHT = 1;

numRegions = length(trialResion(:,1));

SEG_time = cell(numRegions,1);

for N = 1:numRegions
    
    currCycle = [];
    currTime = trialResion(N,:);
    currIdx  = [find(pedarX.time(:,1) <= currTime(1), 1,'last'), ...
        find(pedarX.time(:,1) <= currTime(2), 1,'last')];
    currGRF = pedarX.right.GRF(currIdx(1):currIdx(2),1);
    
    [HC_idx, TO_idx] = YKK_getGaitEvent(currGRF);
        
        
end