GAIT_CYCLE = cell(numRegions,1);

for regionIdx = 1:numRegions
    [r, c] = size(SEG_time{1,1});
    cycleNum = r;
    tmp_cycle = cell(cycleNum,1);
    
    for cycleIdx = 1:cycleNum
        currTime = SEG_time{regionIdx,1}(cycleIdx,:);
        
        seg = [];
        
        seg.startTime = currTime(1);
        seg.midTime = currTime(2);
        seg.endTime = currTime(3);
        
        seg.duration  = currTime(3) - currTime(1);
        
        grf_idx = [find(pedarX.time(:,1) <= currTime(1), 1,'last')...
            find(pedarX.time(:,1) <= currTime(2), 1,'last')...
            find(pedarX.time(:,1) <= currTime(3), 1,'last')];
        
        
        seg.GRF.time     = pedarX.time(grf_idx(1):grf_idx(3));
        seg.GRF.time = seg.GRF.time - min(seg.GRF.time);
        seg.GRF.left.raw     = pedarX.left.GRF(grf_idx(1):grf_idx(3));
        seg.GRF.left.X       = pedarX.left.X(grf_idx(1):grf_idx(3));
        seg.GRF.left.Y       = pedarX.left.Y(grf_idx(1):grf_idx(3));
        
        seg.GRF.right.raw    = pedarX.right.GRF(grf_idx(1):grf_idx(3));
        seg.GRF.right.X      = pedarX.right.X(grf_idx(1):grf_idx(3));
        seg.GRF.right.Y      = pedarX.right.Y(grf_idx(1):grf_idx(3));
        
        for j = 1:numTrigno
            
            emg_idx = [find(trigno{j, 1}.EMG.time(:,1) <= currTime(1), 1,'last')...
                find(trigno{j, 1}.EMG.time(:,1) <= currTime(2), 1,'last')...
                find(trigno{j, 1}.EMG.time(:,1) <= currTime(3), 1,'last')];
                        
            seg.EMG.time = trigno{j}.EMG.time(emg_idx(1):emg_idx(3),1);
            seg.EMG.time = seg.EMG.time - min(seg.EMG.time);
            
            seg.EMG.RAW = trigno{j}.EMG.raw(emg_idx(1):emg_idx(3),1);
            seg.EMG.WL = trigno{j}.EMG.wflen(emg_idx(1):emg_idx(3),1);
            
            if (isORN(j))
                orn_idx = [find(trigno{j, 1}.ORN.time(:,1) <= currTime(1), 1,'last')...
                    find(trigno{j, 1}.ORN.time(:,1) <= currTime(2), 1,'last')...
                    find(trigno{j, 1}.ORN.time(:,1) <= currTime(3), 1,'last')];
                
                seg.ORN.time = trigno{j}.ORN.time(orn_idx(1):orn_idx(3),1);
                seg.ORN.time = seg.ORN.time - min(seg.ORN.time);
                seg.ORN.PITCH = trigno{j}.ORN.pitch(orn_idx(1):orn_idx(3),1);
                seg.ORN.ROLL = trigno{j}.ORN.roll(orn_idx(1):orn_idx(3),1);
                
                tmp_cycle{regionIdx,1} = seg;
            else                
                imu_idx = [find(trigno{j, 1}.IMU.time(:,1) <= currTime(1), 1,'last')...
                    find(trigno{j, 1}.IMU.time(:,1) <= currTime(2), 1,'last')...
                    find(trigno{j, 1}.IMU.time(:,1) <= currTime(3), 1,'last')];
                
                seg.IMU.time = trigno{j}.IMU.accX(imu_idx(1):imu_idx(3),1);
                seg.IMU.time = seg.IMU.time - min(seg.IMU.time);
                seg.IMU.PITCH = trigno{j}.IMU.accY(imu_idx(1):imu_idx(3),1);
                seg.IMU.ROLL = trigno{j}.IMU.accZ(imu_idx(1):imu_idx(3),1);                
            end
            tmp_cycle{j,cycleIdx} = seg;            
        end       
      
    end
      GAIT_CYCLE{regionIdx,1} =  tmp_cycle;
end