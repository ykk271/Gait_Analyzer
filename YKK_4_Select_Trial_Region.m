%%%%% USER INPUT %%%%%%%%%%
isNEWSEGMENTATION = 1;
isRIGHT = 1;
%%%%%%%%%%%%%%%%%%%
if (isRIGHT)
    segFeat      = pedarX.right.GRF;
    segTime      = pedarX.time;
    oppFeat      = pedarX.left.GRF;
else
    
    segFeat      = pedarX.left.GRF;
    segTime      = pedarX.time;
    oppFeat      = pedarX.right.GRF;
end

close all;
fprintf('--------SELEC TRIAL REGION START------------\n');
segRegionFig               = figure;
segRegionFig.Position      = DEFINED.figPOSITION.large;
segRegionFig.Color         = 'w';

subplot(4,1,1);
YKK_GUI_TEXT('Select Trial Region',RED)

subplot(4,1,2); hold on;
plot(segTime, segFeat,  'Color', RED);
plot(segTime, oppFeat,  'Color', '#888888');
ylim([0 1200]);

trialRegion = [];

segFinish = 1;
while (segFinish)
    while(1)
        waitforbuttonpress;
        tmp = get(segRegionFig, 'CurrentKey');
        if strcmp(tmp,'space')
            if (segFinish)
                [t, x] = ginput(2);
                trialTime = sort([t(1) t(2)]);
                trialRegion = [trialRegion; trialTime];
                
                subplot(4,1,2);
                YKK_drawInterval(trialTime(1),trialTime(2),1);
            end

            
            break;
            
        elseif strcmp(tmp,'d')
                [t, x] = ginput(2);
                trialTime = sort([t(1) t(2)]);
        elseif strcmp(tmp,'e')
            segFinish = 0;
            break;
        end
    end
    
%     if (segFinish)
%         [t, x] = ginput(2);
%         trialTime = sort([t(1) t(2)]);        
%         trialRegion = [trialRegion; trialTime];        
%         
%         subplot(4,1,2);
%         YKK_drawInterval(trialTime(1),trialTime(2),1);        
%     end
end

close(segRegionFig)
fprintf('--------SELEC TRIAL REGION END------------\n');

save('trialRegion.mat','trialRegion')






