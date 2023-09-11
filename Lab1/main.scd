s.boot;
s.quit;
s.scope;

FreqScope(800, 400, 0, server: s);
(
SynthDef(\firstSynth, {
	var output = LFPulse.ar(440, width: 0.8);
	Out.ar(0, {output}!2);
}).play;
)



(
SynthDef(\secondSynth, {
	var detune = 1000;
	var sine1 = SinOsc.ar(440 + detune);
	var sine2 = SinOsc.ar(440 - detune);
	var output = sine1 + sine2 /2;

	Out.ar(0, {output}!2);
}).play;
)

(
SynthDef(\secondSynth, {

	var sine1 = SinOsc.kr(1).range(0, 1);
	var sine2 = LFSaw.ar(329.63);
	var output = sine2 * sine1;

	Out.ar(0, {output}!2);
}).play;
)

(
SynthDef(\thirdSynth, {

	var pwm = SinOsc.kr(0.4);
	var pulse = LFPulse.ar(440, width: pwm);

	var output = pulse/2;

	Out.ar(0, {output}!2);
}).play;
)

//Ring modulation?
(
SynthDef(\fourthSynth, {

	var sine1 = SinOsc.ar(220).range(-1, 1);
	var sine2 = LFSaw.ar(220);
	var output = sine2 * sine1 /2;

	Out.ar(0, {output}!2);
}).play;
)

//FM-syntes
(
SynthDef(\fifthSynth, {

	var sine1 = SinOsc.kr(1).range(-1,1);
	var sine2 = SinOsc.ar(329.63 * sine1);
	var output = sine2/2;

	Out.ar(0, {output}!2);
}).play;
)

//Distorsion
(
SynthDef(\fifthSynth, {

	var sine1 = SinOsc.ar(220);
	var sine2 = SinOsc.ar(329.63);
	var output = (sine1 + sine2)/2;
	output = output.softclip(-0.5, 0.5);
	Out.ar(0, {output}!2);
}).play;
)

//Server
(
SynthDef(\firstSynth, {
	arg inputFrequency = 220;
	var output = SinOsc.ar(inputFrequency);
	Out.ar(0, {output}!2);
}).add;
)

//Klient
(
{
var notes = [57, 60, 64, 69];
~myFirstSynth = Synth.new(\firstSynth).register;
fork({
	loop({
		for (0, notes.size-1, { arg index;
			~myFirstSynth.set(\inputFrequency, notes[index].midicps);
			0.3.wait;
		});
	});
});
}.value
)