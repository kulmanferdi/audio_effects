function tremoloSignal = customTremolo(inputSignal, Fs, rate, depth, wetDryMix)
    inputSignal = inputSignal / max(abs(inputSignal));

    t = (0:length(inputSignal)-1)' / Fs; 
    lfo = 1 - depth * (0.5 + 0.5 * sin(2 * pi * rate * t));

    modulated = inputSignal .* lfo;

    tremoloSignal = wetDryMix * modulated + (1 - wetDryMix) * inputSignal;

    tremoloSignal = tremoloSignal / max(abs(tremoloSignal));
end

[audioIn, Fs] = audioread('samples/calling-after-me-lead.mp3');

rate = 6; 
depth = 0.9; 
wetDryMix = 0.7; 
tremoloSignal = customTremolo(audioIn, Fs, rate, depth, wetDryMix);

audiowrite('outputs/calling-after-me-lead-tremolo.wav', tremoloSignal, Fs);
