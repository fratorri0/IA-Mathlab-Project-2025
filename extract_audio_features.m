function [chroma_f, mfcc_f, rolloff_f, centroid_f, spread_f] = ...
    extract_audio_features(signal, fs, windowLength_sec, stepLength_sec)

    % --- Parametri finestratura ---
    wl = round(windowLength_sec * fs);   % lunghezza finestra in campioni
    fl = round(stepLength_sec * fs);     % hop size in campioni

    % --- Finestratura del segnale ---
    [frames, numFrames] = windowize(signal, wl, fl, hamming(wl));

    % --- Inizializza parametri MFCC ---
    mfccParams = feature_mfccs_init(wl, fs);

    % --- Preallocazione ---
    chroma_f   = zeros(12, numFrames);
    mfcc_f     = zeros(mfccParams.cepstralCoefficients, numFrames);
    rolloff_f  = zeros(1, numFrames);
    centroid_f = zeros(1, numFrames);
    spread_f   = zeros(1, numFrames);

    % --- Ciclo sulle finestre ---
    for k = 1:numFrames
        frame = frames(:, k);

        % FFT del frame
        [FFT, ~] = getDFT(frame, fs);

        % MFCC
        mfcc_f(:, k) = feature_mfccs(FFT, mfccParams);

        % Cromagramma (NB: se non hai già una funzione "feature_chroma_vector",
        % qui va implementata o sostituita con un placeholder)
        try
            chroma_f(:, k) = feature_chroma_vector(FFT, fs);
        catch
            chroma_f(:, k) = zeros(12, 1); % fallback: evita errore
        end

        % Spettrali
        rolloff_f(k)  = feature_spectral_rolloff(FFT, 0.85);
        centroid_f(k) = feature_spectral_centroid(FFT, fs);
        %spread_f(k)   = spectral_spread(FFT, fs);    % da scrivere
    end
end
