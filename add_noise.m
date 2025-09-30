% Funzione helper per aggiungere rumore
function noisy_signal = add_noise(signal, noise, snr_db)
    % Ripeti il rumore per assicurarti che sia lungo quanto il segnale
    if length(noise) < length(signal)
        noise = repmat(noise, ceil(length(signal) / length(noise)), 1);
    end
    
    signal_power = sum(signal.^2) / length(signal);
    noise_power = sum(noise.^2) / length(noise);
    
    % Calcola il fattore di scaling del rumore
    snr_linear = 10^(snr_db / 10);
    scaling_factor = sqrt(signal_power / (noise_power * snr_linear));
    
    % Seleziona solo la parte di rumore della stessa lunghezza del segnale
    scaled_noise = scaling_factor * noise(1:length(signal));
    
    noisy_signal = signal + scaled_noise;
end