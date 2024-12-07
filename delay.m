function echoSignal = customDelay(inputSignal, Fs, delayTime, decayFactor, wetDryMix)
    inputSignal = inputSignal / max(abs(inputSignal));

    delaySamples = round(delayTime * Fs); 
    outputLength = length(inputSignal) + delaySamples; 
    echoSignal = zeros(outputLength, 1); 

    for n = 1:length(inputSignal)
        echoSignal(n) = inputSignal(n); 
        if n > delaySamples
            echoSignal(n) = echoSignal(n) + decayFactor * echoSignal(n - delaySamples);
        end
    end

    echoSignal = wetDryMix * echoSignal(1:length(inputSignal)) + (1 - wetDryMix) * inputSignal;

    echoSignal = echoSignal / max(abs(echoSignal));
end

[audioIn, Fs] = audioread('samples/are-you-bored-yet.mp3');
audioIn = audioIn(:, 1);

delayTime = 0.5;
decayFactor = 0.5; 
wetDryMix = 0.5; 
echoSignal = customDelay(audioIn, Fs, delayTime, decayFactor, wetDryMix);

audiowrite('outputs/are-you-bored-yet-delay.wav', echoSignal, Fs);
