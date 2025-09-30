function F = PSD_max(y, t,tend)
%Function to calculate the main frequency
    % --- Abandon the transition period ---
    transient_time = tend*0.7;
    valid_idx = t >= transient_time;
    t_valid = t(valid_idx);
    yout_valid = y(valid_idx, :);
    
    N = length(t_valid);
    t_new = linspace(t_valid(1), t_valid(end), N);
    dt = t_new(2) - t_new(1);
    fs = 1/dt;
    
    B = yout_valid(:,1);
    
    B_interp = interp1(t_valid, B, t_new, 'pchip');

    B_detrend = detrend(B_interp, 'linear');

    window = floor(N/5);
    noverlap = round(0.5 * window);
    nfft = 16384;
    
    [Pxx_B, f] = pwelch(B_detrend, window, noverlap, nfft, fs, 'onesided');
    [peaks_B, locs_B] = findpeaks(Pxx_B, f, 'MinPeakDistance', 0.0001,'MinPeakHeight', 0.001 * max(Pxx_B));
    [~,idx]=max(peaks_B);
    F = locs_B(idx);
end