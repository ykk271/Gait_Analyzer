%%%%% USER INPUT %%%%%%%%%%
isNEWSEGMENTATION = 1;
isRIGHT = 1;
heelID = 14;
refEMGID = 16;
%%%%%%%%%%%%%%%%%%%

if (isRIGHT)
    GRFData = pedarX.right.GRF;
    GRFHeel = pedarX.right.heel;
    GRFTime = pedarX.time;
else
    GRFData = pedarX.left.GRF;
    GRFHeel = pedarX.left.heel;
    GRFTime = pedarX.time;
end

trignoData = trigno{refEMGID}.EMG.wflen;
trignoTime = trigno{refEMGID}.EMG.time;
trignoName = 'EMG (mV)';

accData = trigno{heelID}.IMU.accZ;
accTime = trigno{heelID}.IMU.time;
accName = 'HEEL accZ';

if trignoTime(end) < GRFTime(end)
    currXRange = [0 trignoTime(end)/5];
else
    currXRange = [0 GRFTime(end)/5];
end


syncRegionFig = figure;
syncRegionFig.Position = DEFINED.figPOSITION.large;
syncRegionFig.Color      = 'w';

subplot(4,1,1);
YKK_GUI_TEXT('Select Trigno Trigger',RED)

subplot(4,1,2);
plot(accTime, accData,'Color', RED);
xlim(currXRange);

subplot(4,1,3);
plot(trignoTime, trignoData,'Color', RED);
xlim(currXRange);

subplot(4,1,4);
plot(GRFTime, GRFData,'Color', BLUE);
xlim(currXRange);

if isNEWSEGMENTATION == 1    
    
    while 1
        waitforbuttonpress;
        tmp = get(syncRegionFig, 'CurrentKey');
        if strcmp(tmp,'space')
            break;
        end
    end
    
    [t1,x] = ginput(1);
    
    subplot(4,1,1);
    YKK_GUI_TEXT('Select Pedar Trigger',BLUE)
    
    while 1
        waitforbuttonpress;
        tmp = get(syncRegionFig, 'CurrentKey');
        if strcmp(tmp,'space')
            break;
        end
    end 

    [t2,x] = ginput(1);    
end

triggerTrigno = t1;
triggerPedarX = t2;

timeDiff = abs(t1 - t2);

idxDiff  = floor(timeDiff * pedarX.rate);
if triggerTrigno > triggerPedarX %PedarX was turned on first. delete PedarX
    GRFTime = GRFTime + timeDiff;
else %delete PedarX time
    GRFTime = GRFTime - timeDiff;
end

subplot(4,1,4);
plot(GRFTime, GRFData,'Color', BLUE);
xlim(currXRange);


for i = 5:-1:1
    subplot(4,1,1);
    YKK_GUI_TEXT(sprintf('%d 초 후 종료',i),BLACK)
    
    pause(1);
end

close(syncRegionFig)


pedarX.time = GRFTime;