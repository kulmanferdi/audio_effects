function chorusSignal = customChorus(inputSignal, Fs, depth, rate, wetDryMix)
    inputSignal = inputSignal / max(abs(inputSignal));

    depthSamples = round(depth * Fs); 
    lfoSamples = round(Fs / rate);    
    lfo = sin(2 * pi * (0:lfoSamples - 1) / lfoSamples)'; 

    chorusSignal = zeros(size(inputSignal));
    delayBuffer = zeros(depthSamples, 1); 
    writeIndex = 1;

    for n = 1:length(inputSignal)
        modIndex = mod(n, lfoSamples) + 1;
        currentDelay = round((1 + lfo(modIndex)) * depthSamples / 2);

        readIndex = mod(writeIndex - currentDelay - 1, depthSamples) + 1;
        delayedSample = delayBuffer(readIndex);

        delayBuffer(writeIndex) = inputSignal(n);

        chorusSignal(n) = wetDryMix * delayedSample + (1 - wetDryMix) * inputSignal(n);

        writeIndex = mod(writeIndex, depthSamples) + 1;
    end

    chorusSignal = chorusSignal / max(abs(chorusSignal));
end


depth = 0.01; 
rate = 0.3; 
wetDryMix = 0.5; 

[audioIn, Fs] = audioread('samples/remember-when-bass.mp3');
chorusSignal = customChorus(audioIn, Fs, depth, rate, wetDryMix);
audiowrite('outputs/remember-when-bass-chorus.wav', chorusSignal, Fs);

[audioIn, Fs] = audioread('samples/calling-after-me-rythmn.mp3');
chorusSignal = customChorus(audioIn, Fs, depth, rate, wetDryMix);
audiowrite('outputs/calling-after-me-rythmn-chorus.wav', chorusSignal, Fs);
