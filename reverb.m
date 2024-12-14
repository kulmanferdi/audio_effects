function reverbSignal = customReverberator(inputSignal, Fs, reverbTime, wetDryMix)
    inputSignal = inputSignal / max(abs(inputSignal));

    combDelays = [0.030, 0.040, 0.050, 0.080]; 
    combGains = exp(-3 * combDelays / reverbTime); 
    
    dampingFactor = 0.3;  

    allPassDelays = [0.022, 0.015];
    allPassGains = [0.5, 0.5];

    combDelaysSamples = round(combDelays * Fs);
    allPassDelaysSamples = round(allPassDelays * Fs);

    signal = inputSignal;

    combOutputs = zeros(length(signal), length(combDelays));
    for i = 1:length(combDelays)
        combOutputs(:, i) = combFilterDamped(signal, combDelaysSamples(i), combGains(i), dampingFactor);
    end
    combOutputSum = sum(combOutputs, 2);

    allPassOutput = combOutputSum;
    for i = 1:length(allPassDelays)
        allPassOutput = allPassFilter(allPassOutput, allPassDelaysSamples(i), allPassGains(i));
    end

    reverbSignal = wetDryMix * allPassOutput + (1 - wetDryMix) * signal;

    reverbSignal = reverbSignal / max(abs(reverbSignal));
end

function output = combFilterDamped(input, delaySamples, gain, dampingFactor)
    buffer = zeros(delaySamples, 1);
    output = zeros(size(input));
    lowpass = 0;  % Low-pass filter state

    for n = 1:length(input)
        delayedSample = buffer(end);
        lowpass = (1 - dampingFactor) * delayedSample + dampingFactor * lowpass;
        output(n) = input(n) + gain * lowpass;
        buffer = [input(n); buffer(1:end-1)];
    end
end

function output = allPassFilter(input, delaySamples, gain)
    buffer = zeros(delaySamples, 1); 
    output = zeros(size(input));
    for n = 1:length(input)
        delayedSample = buffer(end);
        output(n) = -gain * input(n) + delayedSample + gain * output(max(n-1,1));
        buffer = [input(n) + gain * delayedSample; buffer(1:end-1)];
    end
end


reverbTime = 10.5; 
wetDryMix = 0.75;

[audioIn, Fs] = audioread('samples/are-you-bored-yet.mp3');
reverbSignal = customReverberator(audioIn, Fs, reverbTime, wetDryMix);
audiowrite('outputs/are-you-bored-yet-reverb2.wav', reverbSignal, Fs);

[audioIn, Fs] = audioread('samples/calling-after-me-lead.mp3');
reverbSignal = customReverberator(audioIn, Fs, reverbTime, wetDryMix);
audiowrite('outputs/calling-after-me-lead-reverb2.wav', reverbSignal, Fs);
