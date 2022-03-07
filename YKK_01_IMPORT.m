clc; clear; close all;
YKK_Global_Constant;
YKK_COLOR;

filePath = 'C:\Users\YKK\Desktop\MYOSUIT_MOTEK - 복사본\MYOSUIT_MOTEK - 복사본\DATA\JWK';
fileName = '01 MYOSUIT WO UPRIGHT';

fprintf('--------CONFIG EXPERIMENT START-------\n');

trignoDataName  =  sprintf('%s\\%s.csv',filePath,fileName);
padarDataName  =  sprintf('%s\\%s.fgt',filePath,fileName);



%%%%%% USER INPUT %%%%%%
envConfig.winWflen   = 0.050; %unit second
envConfig.winEnv     = 0.050; %unit second
% envConfig.cutOffFreq = [20 500]; %Hz
%%%%%%%%%%%%%%%%%%%%%%%%

idxStart    = JWKgetTRIGNOSTARTIDX(trignoPosition, idxORN, DEFINED.offset.ORN.Total, DEFINED.offset.IMU.Total);


%% TRIGNO
fprintf('--------TRIGNO IMPORT START-----------\n');

rawTrigno   = readmatrix(trignoDataName); % IMPORT Raw Data
trigno      = cell(numTrigno,1);

for idx = 1: numTrigno
    currStart       = idxStart(idx);
    currPosition    = strsplit(trignoPosition{idx});
    trigno{idx}.position = currPosition{3};
    if ismember(idx, idxORN)
        trigno{idx}.isORN    = 1;
        trigno{idx}.EMG.raw   = rawTrigno(:, currStart + DEFINED.offset.ORN.EMG);
        trigno{idx}.EMG.time  = rawTrigno(:, currStart + DEFINED.offset.ORN.EMGtime);
        trigno{idx}.EMG.rate  = 1/(trigno{idx}.EMG.time(5) - trigno{idx}.EMG.time(4));
        %         trigno{idx}.EMG.env   = JWKenvelop(trigno{idx}.EMG.raw,trigno{idx}.EMG.rate,envConfig.winEnv, envConfig.cutOffFreq);
        trigno{idx}.EMG.wflen = JWKwflen(trigno{idx}.EMG.raw,     trigno{idx}.EMG.rate,envConfig.winWflen);
        
        trigno{idx}.ORN.time  = rawTrigno(:, currStart + DEFINED.offset.ORN.ORNtime);
        trigno{idx}.ORN.rate  = 1/(trigno{idx}.ORN.time(5) - trigno{idx}.ORN.time(4));
        trigno{idx}.ORN.pitch = rawTrigno(:, currStart + DEFINED.offset.ORN.Pitch);
        trigno{idx}.ORN.roll  = rawTrigno(:, currStart + DEFINED.offset.ORN.Roll);
        trigno{idx}.ORN.yaw   = rawTrigno(:, currStart + DEFINED.offset.ORN.Yaw);
    else
        trigno{idx}.isORN     = 0;
        trigno{idx}.EMG.raw   = rawTrigno(:, currStart + DEFINED.offset.IMU.EMG);
        trigno{idx}.EMG.time  = rawTrigno(:, currStart + DEFINED.offset.IMU.EMGtime);
        trigno{idx}.EMG.rate  = 1/(trigno{idx}.EMG.time(5) - trigno{idx}.EMG.time(4));
        %         trigno{idx}.EMG.env   = JWKenvelop(trigno{idx}.EMG.raw,trigno{idx}.EMG.rate,envConfig.winEnv, envConfig.cutOffFreq);
        trigno{idx}.EMG.wflen = JWKwflen(trigno{idx}.EMG.raw,     trigno{idx}.EMG.rate,envConfig.winWflen);
        
        trigno{idx}.IMU.time  = rawTrigno(:, currStart + DEFINED.offset.IMU.Acctime);
        trigno{idx}.IMU.rate  = 1/(trigno{idx}.IMU.time(5) - trigno{idx}.IMU.time(4));
        trigno{idx}.IMU.accX  = rawTrigno(:, currStart + DEFINED.offset.IMU.AccX);
        trigno{idx}.IMU.accY  = rawTrigno(:, currStart + DEFINED.offset.IMU.AccY);
        trigno{idx}.IMU.accZ  = rawTrigno(:, currStart + DEFINED.offset.IMU.AccZ);
    end    
end

fprintf('--------TRIGNO IMPORT COMPLETE--------\n');


%% PEDAR
fprintf('--------TRIGNO IMPORT START-----------\n');

opt = {'HeaderLines',9};
fmt = repmat('%f',1,7);
str = fileread(padarDataName);
FGT = textscan(strrep(str,',','.'),fmt,opt{:});
time  = FGT{1};
Ch1F  = FGT{2};
Ch1X  = FGT{3};
Ch1Y  = FGT{4};
Ch2F  = FGT{5};
Ch2X  = FGT{6};
Ch2Y  = FGT{7};

padarDataName = padarDataName(1:end-3);
padarDataName = [padarDataName 'asc'];

opt = {'HeaderLines',10};
fmt = repmat('%f',1,199);
str = fileread(padarDataName);
ASC = textscan(strrep(str,',','.'),fmt,opt{:});

leftHeel = zeros(length(ASC{1}),1);
for i = 1 : 26
    leftHeel = ASC{1+i} + leftHeel;
end

rightHeel = zeros(length(ASC{1}),1);
for i = 1 : 26
    rightHeel = ASC{99+i} + rightHeel;
end

pedarX.time       = imresize(time, [length(time)*20 1]);
pedarX.rate       = 1000;
pedarX.left.GRF   = imresize(Ch1F, [length(Ch1F)*20 1]);
pedarX.left.X     = imresize(Ch1X, [length(Ch1X)*20 1]);
pedarX.left.Y     = imresize(Ch1Y, [length(Ch1Y)*20 1]);
pedarX.left.heel  = imresize(leftHeel, [length(leftHeel)*20 1]);
pedarX.right.GRF  = imresize(Ch2F, [length(Ch2F)*20 1]);
pedarX.right.X    = imresize(Ch2X, [length(Ch2X)*20 1]);
pedarX.right.Y    = imresize(Ch2Y, [length(Ch2Y)*20 1]);
pedarX.right.heel = imresize(rightHeel, [length(rightHeel)*20 1]);

fprintf('--------pedarX IMPORT COMPLETE--------\n');




