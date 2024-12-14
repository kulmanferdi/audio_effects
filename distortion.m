function distortionSignal = customDistortion(inputSignal, gain, clipLevel, wetDryMix)
    inputSignal = inputSignal / max(abs(inputSignal));

    distorted = gain * inputSignal; 
    distorted(distorted > clipLevel) = clipLevel; 
    distorted(distorted < -clipLevel) = -clipLevel; 

    distorted = distorted / max(abs(distorted));

    distortionSignal = wetDryMix * distorted + (1 - wetDryMix) * inputSignal;

    distortionSignal = distortionSignal / max(abs(distortionSignal));
end

gain = 3; 
clipLevel = 0.4;
wetDryMix = 0.78; 

[audioIn, Fs] = audioread('samples/fake-tales-of-san-francisco.mp3');
distortionSignal = customDistortion(audioIn, gain, clipLevel, wetDryMix);
audiowrite('outputs/fake-tales-of-san-francisco-overdrive.wav', distortionSignal, Fs);

[audioIn, Fs] = audioread('samples/phonk-808-bass-sustained_90bpm_G#_major.wav');
distortionSignal = customDistortion(audioIn, gain, clipLevel, wetDryMix);
audiowrite('outputs/phonk-808-bass-sustained_90bpm_G#_major-drive.wav', distortionSignal, Fs);
