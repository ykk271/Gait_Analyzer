load('trialResion.mat');

isRIGHT = 1;

numRegions = length(trialResion(:,1));

SEG_time = cell(numRegions,1);

close all;
fprintf('--------SELEC TRIAL REGION START------------\n');
segRegionFig               = figure;
segRegionFig.Position      = DEFINED.figPOSITION.large;
segRegionFig.Color         = 'w';

for N = 1:numRegions
    currCycle = [];
    currTime = trialResion(N,:);
    
    
    subplot(4,1,1);
    YKK_GUI_TEXT(sprintf('%d/%d th Trial',N,numRegions),BLACK)
    
    if(isRIGHT)
        subplot(4,1,3); hold on;
        plot(pedarX.time, pedarX.right.GRF,  'Color', BLACK);
        ylim([0 1200]);
        xlim(currTime);
        
        subplot(4,1,4); hold on;
        plot(pedarX.time, pedarX.left.GRF,  'Color', BLACK);
        ylim([0 1200]);
        xlim(currTime);
    end
    
    
    segFinish = 1;
    
    while (segFinish)
        subplot(4,1,2);
        YKK_GUI_TEXT('Select Start HC point',RED)
        
        while(1)
            waitforbuttonpress;
            tmp = get(segRegionFig, 'CurrentKey');
            if strcmp(tmp,'space')
                break;
            elseif strcmp(tmp,'e')
                segFinish = 0;
                break;
            end
        end        
        
        if (segFinish)        
            [t1, x] = ginput(1);           
            
            subplot(4,1,3);
            xline(t1,'RED');            
            subplot(4,1,2);
            YKK_GUI_TEXT('Select TO point',BLUE)            
            while(1)
                waitforbuttonpress;
                tmp = get(segRegionFig, 'CurrentKey');
                if strcmp(tmp,'space')
                    break;
                end
            end            
            [t2, x] = ginput(1);
            xline(t2,'BLUE');
            
            subplot(4,1,3); 
            xline(t1,'RED');            
            subplot(4,1,2);
            YKK_GUI_TEXT('Select END HC point',RED)            
            while(1)
                waitforbuttonpress;
                tmp = get(segRegionFig, 'CurrentKey');
                if strcmp(tmp,'space')
                    break;
                end
            end            
            [t3, x] = ginput(1);
            xline(t3,'RED');           
                       
            currCycle = [currCycle; [t1, t2, t3]];          
         end
    end
    
    SEG_time{N,1} = currCycle;
    clearvars currCycle;
    
end

close(segRegionFig)

