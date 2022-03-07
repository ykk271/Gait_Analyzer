%%%%% USER INPUT %%%%%%%%%%
isNEWSEGMENTATION = 1;
isRIGHT = 1;
calID = 1;
refEMGID = 16;
%%%%%%%%%%%%%%%%%%%

angleData = trigno{calID}.ORN.pitch;
angleTime = trigno{calID}.ORN.time;
angleName = 'Pedal';


trignoData = trigno{refEMGID}.EMG.wflen;
trignoTime = trigno{refEMGID}.EMG.time;
trignoName = 'EMG (mV)';

maxTime = max(angleTime);
currXRange = [0 maxTime/5];
% currXRange = [0 100];


calibRegionFig = figure;
calibRegionFig.Position = DEFINED.figPOSITION.large;
calibRegionFig.Color      = 'w';

sgtitle('ANGLE REFERENCE')

subplot(3,1,1);
YKK_GUI_TEXT('Select static region',RED)

subplot(3,1,2);
plot(trignoTime, trignoData, 'Color', '#333333');
xlim(currXRange);
ylim([-max(trignoData)/10 max(trignoData*1.2)]);
xlabel('time (s)');
ylabel(trignoName);

subplot(3,1,3);
plot(angleTime, angleData, 'Color', '#333333');
xlim(currXRange);
ylim([-180 180]);
xlabel('time (s)');
ylabel(angleName);

if isNEWSEGMENTATION == 1
    fprintf('press SPACE when ready \n');
    while 1
        waitforbuttonpress;
        tmp = get(calibRegionFig, 'CurrentKey');
        if strcmp(tmp,'space')
            break;
        end
    end
    [t,x] = ginput(2); analysisTime = sort([t(1) t(2)]);
    fprintf('analysis :: region :: %0.2f-%0.2f sec\n', analysisTime(1), analysisTime(2));
end



for idx = 1: numTrigno
    if  trigno{idx}.isORN    == 1
        startIdx = floor(analysisTime(1)*trigno{idx}.ORN.rate)+1;
        endIdx   = floor(analysisTime(2)*trigno{idx}.ORN.rate)-1;
        
        
        %%% PITCH
        currFeat = trigno{idx}.ORN.pitch;
        refValue = mean(currFeat(startIdx:endIdx));
        featStd  = movstd(currFeat,3);
        
        idxArtifact     = (featStd> 100);
        onsetNoise      = find(diff(idxArtifact) == 1)+1;
        offsetNoise     = find(diff(idxArtifact) == -1);
        
        for idxArtifact = 1 : length(onsetNoise)
            currFeat(onsetNoise(idxArtifact)+1) = (currFeat(onsetNoise(idxArtifact)) + currFeat(offsetNoise(idxArtifact)))/2;
        end
        trigno{idx}.ORN.pitch = currFeat - refValue;
        
        
        %%% ROLL
        currFeat = trigno{idx}.ORN.roll;
        refValue = mean(currFeat(startIdx:endIdx));
        featStd  = movstd(currFeat,3);
        
        idxArtifact     = (featStd> 100);
        onsetNoise      = find(diff(idxArtifact) == 1)+1;
        offsetNoise     = find(diff(idxArtifact) == -1);
        for idxArtifact = 1 : length(onsetNoise)
            currFeat(onsetNoise(idxArtifact)+1) = (currFeat(onsetNoise(idxArtifact)) + currFeat(offsetNoise(idxArtifact)))/2;
        end
        trigno{idx}.ORN.roll = currFeat - refValue;
        
        currFeat = trigno{idx}.ORN.yaw;
        refValue = mean(currFeat(startIdx:endIdx));
        featStd  = movstd(currFeat,3);
        
        idxArtifact     = (featStd> 100);
        onsetNoise      = find(diff(idxArtifact) == 1)+1;
        offsetNoise     = find(diff(idxArtifact) == -1);
        for idxArtifact = 1 : length(onsetNoise)
            currFeat(onsetNoise(idxArtifact)+1) = (currFeat(onsetNoise(idxArtifact)) + currFeat(offsetNoise(idxArtifact)))/2;
        end
        
        
        trigno{idx}.ORN.pitch = trigno{idx}.ORN.pitch - mean(trigno{idx}.ORN.pitch(startIdx:endIdx));
        trigno{idx}.ORN.roll  = trigno{idx}.ORN.roll - mean(trigno{idx}.ORN.roll(startIdx:endIdx));
        
    end
    
end


angleData = trigno{calID}.ORN.pitch;
angleTime = trigno{calID}.ORN.time;


subplot(3,1,2);
plot(trignoTime, trignoData, 'Color', '#333333');
xlim(currXRange);
ylim([-max(trignoData)/10 max(trignoData*1.2)]);
xlabel('time (s)');
ylabel(trignoName);

subplot(3,1,3);
plot(angleTime, angleData, 'Color', '#333333');
xlim(currXRange);
ylim([-180 180]);
xlabel('time (s)');
ylabel(angleName);

for i = 5:-1:1
    subplot(3,1,1);
    YKK_GUI_TEXT(sprintf('%d 초 후 종료',i),BLUE)
    
    pause(1);
end

close(calibRegionFig)