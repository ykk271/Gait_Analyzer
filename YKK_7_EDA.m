sensorID = 1;
segRegionFig               = figure;
segRegionFig.Position      = [1 41 1920/3 962];
segRegionFig.Color         = 'w';
tiledlayout(8,1) % 1 GRF, 8 EMG, 1 ORN

numTrial = length(GAIT_CYCLE);

nexttile; % GRF
for T = 1:numTrial
    [r, cycleNum] = size(GAIT_CYCLE{T, 1});
    for C = 1:cycleNum
        plot(GAIT_CYCLE{T, 1}{C, C}.GRF.time, GAIT_CYCLE{T, 1}{C, C}.GRF.right.raw); hold on;
    end
end
xticks([]);

Sensor_ID =[2, 4, 6, 8, 10, 16];

for i = 1:length(Sensor_ID)
    SENSOR_ID = (Sensor_ID(i));
    nexttile; % RF
    for T = 1:numTrial
        [r, cycleNum] = size(GAIT_CYCLE{T, 1});
        for C = 1:cycleNum
            plot(GAIT_CYCLE{T, 1}{SENSOR_ID, C}.EMG.time, GAIT_CYCLE{T, 1}{SENSOR_ID, C}.EMG.WL); hold on;
        end
    end
    
    xticks([]);
    yticks([]);
end

SENSOR_ID = 4;
nexttile;
for T = 1:numTrial
    [r, cycleNum] = size(GAIT_CYCLE{T, 1});
    for C = 1:cycleNum
        plot(GAIT_CYCLE{T, 1}{SENSOR_ID, C}.ORN.time, GAIT_CYCLE{T, 1}{SENSOR_ID, C}.ORN.PITCH); hold on;
    end    

    yticks([]);
end









