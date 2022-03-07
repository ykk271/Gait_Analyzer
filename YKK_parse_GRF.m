function [index_rise] = YKK_parse_GRF(curr_grf,EMG_length,init_thresh, final_thresh, close_thresh)
%grf 200 0.3 0.1 50

smooth_data = smoothdata(curr_grf);

init_thresh              = init_thresh * max(curr_grf);
final_thresh             = final_thresh * max(curr_grf);


above_left_thresh        = zeros(EMG_length,1);
above_left_thresh(smooth_data>init_thresh) = 1;


index_rise = find(diff(above_left_thresh)==1);
num_left_steps = length(index_rise);


for i = 1:num_left_steps-1
    tmp = find(curr_grf(index_rise(i,1):index_rise(i+1,1),1) > final_thresh,1,'first');
    if ~isnan(tmp)
        index_rise(i,1) = tmp+index_rise(i,1);
    end
end

index_too_close = find(diff(index_rise) < close_thresh);
for i = 1: length(index_too_close)
    index_rise(index_too_close(length(index_too_close)-i+1)) = []; % 아래 열부터 빼기 위함    
    
end