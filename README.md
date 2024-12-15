# Audio Effects in MATLAB

This project implements several audio effects in MATLAB, providing simple, easy-to-use functions for audio processing. Each effect simulates a unique aspect of sound design, enhancing audio signals creatively.

## Reverb

Adds depth and realism by simulating natural sound reflections in an environment.

```matlab
function reverbSignal = customReverberator(inputSignal, Fs, reverbTime, wetDryMix)
```

- **inputSignal**: Input audio signal.
- **Fs**: Sampling frequency.
- **reverbTime**: Time for reflections to decay.
- **wetDryMix**: Ratio of processed to original signal.

## Chorus

Produces a rich, shimmering sound by blending delayed and pitch-modulated copies of the input.

```matlab
function chorusSignal = customChorus(inputSignal, Fs, depth, rate, wetDryMix)
```

- **depth**: Maximum delay depth in seconds.
- **rate**: Modulation speed in Hz.
- **wetDryMix**: Ratio of processed to original signal.

## Delay (Echo)

Repeats the input signal with customizable delay and decay, creating rhythmic echoes.

```matlab
function echoSignal = customDelay(inputSignal, Fs, delayTime, decayFactor, wetDryMix)
```

- **delayTime**: Delay time in seconds.
- **decayFactor**: Attenuation of each echo.
- **wetDryMix**: Ratio of processed to original signal.

## Distortion

Adds harmonic saturation or aggressive tones by amplifying and clipping the signal.

```matlab
function distortionSignal = customDistortion(inputSignal, gain, clipLevel, wetDryMix)
```

- **gain**: Amplification applied before clipping.
- **clipLevel**: Threshold for clipping the signal.
- **wetDryMix**: Ratio of processed to original signal.

## Tremolo

Modulates the amplitude to create a pulsating volume effect.

```matlab
function tremoloSignal = customTremolo(inputSignal, Fs, rate, depth, wetDryMix)
```

- **rate**: Modulation rate in Hz.
- **depth**: Intensity of amplitude modulation.
- **wetDryMix**: Ratio of processed to original signal.

## Example

Here is an example of applying an effect:

```matlab
[audioIn, Fs] = audioread('input.wav');
wetDryMix = 0.5;
reverbTime = 1.5;
output = customReverberator(audioIn, Fs, reverbTime, wetDryMix);
audiowrite('output.wav', output, Fs);
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
