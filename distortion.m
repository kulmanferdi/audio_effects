function distortionSignal = customDistortion(inputSignal, gain, clipLevel, wetDryMix)
    inputSignal = inputSignal / max(abs(inputSignal));

    distorted = gain * inputSignal; 
    distorted(distorted > clipLevel) = clipLevel; 
    distorted(distorted < -clipLevel) = -clipLevel; 

    distorted = distorted / max(abs(distorted));

    distortionSignal = wetDryMix * distorted + (1 - wetDryMix) * inputSignal;

    distortionSignal = distortionSignal / max(abs(distortionSignal));
end

[audioIn, Fs] = audioread('samples/fake-tales-of-san-francisco.mp3');

gain = 3; 
clipLevel = 0.4;
wetDryMix = 0.78; 
distortionSignal = customDistortion(audioIn, gain, clipLevel, wetDryMix);

audiowrite('outputs/fake-tales-of-san-francisco-overdrive.wav', distortionSignal, Fs);
