% function [HC_idx, TO_idx] = YKK_getGaitEvent(currGRF)
currGRF = movmean(currGRF, 3);
featSignal = movstd(currGRF,3);

featSignal(featSignal>0.2) = 0.2;

featSignal = JWKnormSignal(featSignal);

tmp = featSignal > 0.1;
tmpRiseIdx = find(diff(tmp) == 1);

searchWin = 100;

for idx = 1 : length(tmpRiseIdx)
    if tmpRiseIdx(idx) > searchWin
        searchRegion = flipud(featSignal(tmpRiseIdx(idx) - searchWin:tmpRiseIdx(idx)));
    else
        searchRegion = flipud(inputSignal(1:tmpRiseIdx(idx)));
    end
    searchRegion = JWKnormSignal(searchRegion) + 0.1;
    locMin = min(searchRegion);
    offset = find(searchRegion < locMin * (1+10/100),1);
    tmpRiseIdx(idx) = tmpRiseIdx(idx) - offset;
end

tmpRiseIdx = unique(tmpRiseIdx);
tmpFallIdx = tmpRiseIdx; 

for idx = 1: (length(tmpRiseIdx)-1)
    searchRegion = featSignal(tmpRiseIdx(idx) + floor((tmpRiseIdx(idx+1) - tmpRiseIdx(idx))/2 ) : tmpRiseIdx(idx+1) - floor((tmpRiseIdx(idx+1) - tmpRiseIdx(idx))/8));
    searchRegion = JWKnormSignal(searchRegion) + 0.1;
    locMin = min(searchRegion);
    offset = find(searchRegion < locMin * (1+10/100),1);
%     tmpFallIdx(idx) = tmpRiseIdx(idx) + floor((tmpRiseIdx(idx+1) - tmpRiseIdx(idx))/2 )  + offset- 1;
end

riseIdx = tmpRiseIdx;
fallIdx = tmpFallIdx;



% end