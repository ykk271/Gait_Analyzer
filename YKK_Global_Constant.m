global trignoPosition
trignoPosition = {
    '01 ORN Rect.Femoris(LEFT)',...
    '02 ORN Rect.Femoris(RIGHT)',...
    '03 ORN Tib.Anterior(LEFT)',...
    '04 ORN Tib.Anterior(RIGHT)',...
    '05 ORN Vast.Med(LEFT)',...
    '06 ORN Vast.Med(RIGHT)',...
    '07 ORN Glute.Max(LEFT)',...
    '08 ORN Glute.Max(RIGHT)',...
    '09 ORN Gastroc.Med(LEFT)',...
    '10 ORN Gastroc.Med(RIGHT)', ...
    '11 ORN Foot(LEFT)', ...
    '12 ORN Foot(RIGHT)', ...
    '13 ORN Torso', ...
    '14 IMU Heel(RIGHT)', ...
    '15 IMU Soleus(LEFT)',...
    '16 IMU Soleus(RIGHT)',...
    };

global isORN
global idxORN
isORN = contains(trignoPosition,'ORN');
idxORN = find(isORN == 1);

global numTrigno;
numTrigno = length(trignoPosition);

global rateEMG_1
global rateEMG_2
global rateORN
global rateIMU
global ratePedarX

rateEMG_1   = 1.7778e+03;
rateEMG_2   = 1.2593e+03;
rateORN     = 74.0741;
rateIMU     = 148.1481;
ratePedarX  = 1000;

global DEFINED

DEFINED.offset.ORN.Total    =  8; DEFINED.offset.ORN.EMGtime    = 0;    DEFINED.offset.ORN.EMG      = 1;
DEFINED.offset.ORN.ORNtime  =  2; DEFINED.offset.ORN.Pitch      = 3;    DEFINED.offset.ORN.Roll     = 5;     DEFINED.offset.ORN.Yaw      = 7;

DEFINED.offset.IMU.Total    = 14; DEFINED.offset.IMU.EMGtime    = 0;    DEFINED.offset.IMU.EMG      = 1;
DEFINED.offset.IMU.Acctime  =  2; DEFINED.offset.IMU.AccX       = 3;    DEFINED.offset.IMU.AccY     = 5;     DEFINED.offset.IMU.AccZ = 7;
DEFINED.offset.IMU.Gyrotime =  8; DEFINED.offset.IMU.GyroX      = 9;   DEFINED.offset.IMU.GyroY    = 11;     DEFINED.offset.IMU.GyroZ = 13;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global DEFINED

DEFINED.figMAP.empty        = 00;
DEFINED.figMAP.rightGRF.total     = 880;
DEFINED.figMAP.rightGRF.heel      = 881;
DEFINED.figMAP.rightGRF.medial     = 882;
DEFINED.figMAP.rightGRF.lateral    = 883;
DEFINED.figMAP.rightGRF.toe       = 884;
DEFINED.figMAP.rightGRF.X         = 885;
DEFINED.figMAP.rightGRF.Y         = 886;
DEFINED.figMAP.rightGRF.accX       = 887;
DEFINED.figMAP.rightGRF.accY       = 888;
DEFINED.figMAP.rightGRF.accZ       = 889;

DEFINED.figMAP.leftGRF.total      = 990;
DEFINED.figMAP.leftGRF.heel       = 991;
DEFINED.figMAP.leftGRF.medial      = 992;
DEFINED.figMAP.leftGRF.lateral     = 993;
DEFINED.figMAP.leftGRF.toe        = 994;
DEFINED.figMAP.leftGRF.X          = 995;
DEFINED.figMAP.leftGRF.Y          = 996;
DEFINED.figMAP.leftGRF.accX       = 997;
DEFINED.figMAP.leftGRF.accY       = 998;
DEFINED.figMAP.leftGRF.accZ       = 999;

DEFINED.figMAP.rightANKLE       = 22;
DEFINED.figMAP.rightANKLEROLL   = 222;
DEFINED.figMAP.leftANKLE        = 33;
DEFINED.figMAP.leftANKLEROLL    = 333;
DEFINED.figMAP.rightKNEE        = 44;
DEFINED.figMAP.rightTRUNK       = 444;
DEFINED.figMAP.leftKNEE         = 55;
DEFINED.figMAP.leftTRUNK        = 555;

DEFINED.figMAP.rightHIP         = 66;
DEFINED.figMAP.leftHIP          = 77;

DEFINED.figPOSITION.large = [1 41 1920 962];
DEFINED.figPOSITION.small = [1 41 300 900];




