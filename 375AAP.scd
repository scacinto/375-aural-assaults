/*

___________________________________________

375 Aural Assaults
___________________________________________


by Scott Petersen (aka scacinto aka nodenoise)

Please feel free to modify, expand, and share code according to the  Creative Commons Attribution-NonCommercial 3.0 Unported License:  Creative Commons Attribution-NonCommercial 3.0 Unported License.

For some more of my projects, code, and music, please see my website scottericpetersen.com.

*/

// ignore this bit - it's just for recording options when I'm exporting to the web
(
s.waitForBoot {
s = Server.local;
s.options.sampleRate = 48000;
s.options.memSize = 4096 * 100;
s.recHeaderFormat = "wav";
s.recSampleFormat = "int24";
s.recChannels = 2;
s.reboot;
s.makeGui;
}
)

/*_____________________________________________________

LET THE ASSAULTS BEGIN!
_______________________________________________________*/

/*ASSAULT #44 : please adjust your radio dial

Instructions for use. 1. Turn your computer volume all the way down. 2. Put on headphones. 3. Carefully raise the volume. 4. Enjoy at a comfortable listening level.

Do not: turn volume all the way up, use headphones, experience bloody headphones.
*/

(
{
	var gate = LFNoise1.kr(25, 0.1, 0).poll;
	var noiz = PinkNoise.ar() * Env.asr(0.01, 1,releaseTime:0.01).kr(gate: gate);
	var filt = Splay.arFill(14, {
		[RLPF.ar(noiz, Demand.kr(gate, 0, Drand(Array.fill(12, {rrand(50, 1500)}),inf)),rrand(0.01,0.5)),
			RHPF.ar(noiz, Demand.kr(gate, 0, Drand(Array.fill(12, {rrand(3500, 5500)}),inf)),rrand(0.0075,0.075))].choose;
	}, level: 1/14, levelComp: false);
	Normalizer.ar( filt );
}.play
)


//ASSAULT #43 : tender dark_train, sing me your sweet song

(
play {
	var train, dark_train;
	train = PulseTrain.ar(Notch.ar(PinkNoise.ar(), LFNoise1.kr(5, 25,0)), 10, 0.5, 1.25);
	train = Normalizer.ar(LeakDC.ar(Compander.ar(train, train, 1, 1, 0.5, 0.001, 0.001  )));
	dark_train = DelayC.ar(train.neg,1, train);
	dark_train = Normalizer.ar(dark_train);
	LeakDC.ar([train,dark_train]);
}
)


//ASSAULT #42 : train + dark_train meet in the pouring rain and eat crickets

(
play {
	var train, dark_train;
	train = PulseTrain.ar(Notch.ar(PinkNoise.ar(), LFNoise1.kr(20, 120, 100)), 10, 0.5, 1.25);
	train = Normalizer.ar(LeakDC.ar(Compander.ar(train, train, 1, 1, 0.5, 0.001, 0.001  )));
	dark_train = DelayC.ar(train.neg,0.1,0.01);
	RLPF.ar([train,dark_train], train.range(-50,1800), train);
}
)


//ASSAULT #41 : All aboard...

(
play {
	var train = PulseTrain.ar(Notch.ar(PinkNoise.ar(), LFNoise1.kr(10, 100,0)), 10, 0.5, 1.25);
	Compander.ar(train, train, 1, 1, 0.5, 0.001, 0.001  ).dup(2);
}
)


//ASSAULT #40 : not a new beginning, but at least it's horrible.

(
play { x= Impulse.ar(10, 0.5);
	z = LPF.ar(LocalIn.ar(1) * 0.75, 4500, 0.75); //raised cutoff to 4500 from 2500
	y= Mix.arFill(4, {CombC.ar(x + z, 0.2, LFNoise1.ar(rrand(0.125,0.5), 0.05, 0.07), rrand(0.1,1.5),0.5) > 0.125});
	LocalOut.ar(LeakDC.ar(y));
	Limiter.ar(Limiter.ar(z ! 2));
}
)


//ASSAULT #39 : stereo : less gentle noises (in a cavernous bathroom.)


(play{
	var snd1,snd2,snd3;
	var array = [snd1, snd2, snd3];

	array.size.do({|i|
		var ch = [500, 1000, 2000].at(i);
		var lfo1 = LFNoise1.kr(LFNoise1.kr(1, 0.1, 100), ch, ch*2);
	var lfo2 = LFNoise1.kr(LFNoise1.kr(1, 0.1, 100), 0.49, 0.5).poll;
		var lfo3 = LFNoise1.kr(LFNoise1.kr(0.5, 0.25,0.4), 0.35,0.45);
	var s1 = RLPF.ar(PinkNoise.ar(), lfo1, lfo2);
	var s2 = RLPF.ar(PinkNoise.ar() * s1, lfo1, lfo2);
		s2 = Compander.ar(s2, s2, 0.15, 10, 1);
		s2 = Pan2.ar(s2, (lfo2 -0.2) * 2);
		array[i] = FreeVerb.ar(s2, lfo3, 0.8, 0.2);
		//array[i] = s2;
	});
	array = Normalizer.ar(array.frac);
	array = Limiter.ar(Compander.ar(array, array, 0.1, 0.1,0.1));
	Mix(array);
})

//ASSAULT #38 : stereo : even gentler noises (in a cavernous bathroom.)


(play{
	var snd1,snd2,snd3;
	var array = [snd1, snd2, snd3];

	array.size.do({|i|
		var ch = [500, 1000, 2000].at(i);
		var lfo1 = LFNoise1.kr(LFNoise1.kr(1, 0.1, 100), ch, ch*2);
	var lfo2 = LFNoise1.kr(LFNoise1.kr(1, 0.1, 100), 0.49, 0.5).poll;
		var lfo3 = LFNoise1.kr(LFNoise1.kr(0.5, 0.25,0.4), 0.35,0.45);
	var s1 = RLPF.ar(PinkNoise.ar(), lfo1, lfo2);
	var s2 = RLPF.ar(PinkNoise.ar() * s1, lfo1, lfo2);
		s2 = Compander.ar(s2, s2, 0.15, 10, 1);
		s2 = Pan2.ar(s2, (lfo2 -0.2) * 2);
		array[i] = FreeVerb.ar(s2, lfo3, 0.8, 0.2);
		//array[i] = s2;
	});

	Mix(array);
})


//ASSAULT #37 : mono : a kindler, gentler noise...

(play{var lfo1 = LFNoise1.kr(LFNoise1.kr(1, 0.1, 100), 500, 1000);var lfo2 = LFNoise1.kr(LFNoise1.kr(1, 0.1, 100), 0.49, 0.5);var snd1 = RLPF.ar(PinkNoise.ar(), lfo1, lfo2);var snd2 = RLPF.ar(PinkNoise.ar() * snd1, lfo1, lfo2);snd2!2;
})




//ASSAULT #36 : stereo ::

//with mods -- P1
(play{
	var line = Line.kr(9,1.5,25);
	var line1 = Line.kr(9.001,1.51,25);

	Slope.ar(SinOsc.ar(SinOsc.ar().hypot(1).mod([line,line1]) * [line1, line] + SinOsc.ar([line1,line]).hypot(1).mod([line,line1]) ) * SinOsc.ar([line, line1]).hypot(1).mod([line1, line]))

})


// -- P2
(play{
	var line = XLine.kr(0.01,20,60);
	var line1 = XLine.kr(0.01,20.5,60);

	Slope.ar(SinOsc.ar(SinOsc.ar().hypot(1) * line + SinOsc.ar(line1).hypot(1) ) * SinOsc.ar(line1).hypot(1)%1)!2
})



//ASSAULT #35 : stereo :: singing

({i = Normalizer.ar(SoundIn.ar(0), 1).sqrt; t = Normalizer.ar(SoundIn.ar(1).sqrt, 1); k = [A2K.kr(t).abs, A2K.kr(i).abs];CombC.ar([i,t], 2, k,k,k);}.play)


//ASSAULT #34 : stereo :: speaking

({i = Normalizer.ar(SoundIn.ar(0), 1).sqrt; t = Normalizer.ar(SoundIn.ar(1).sqrt, 1); k = [A2K.kr(t).abs, A2K.kr(i).abs];CombC.ar([i,t], 2, k,k,k);}.play)



//ASSAULT #33 : stereo
// SC_140625_163452.aiff
// just put the buses in an array and call from the function by index :P

(

~num = 3;
~buses = Array.fill(~num, {Bus.audio(s,1)});

play{

	g = Array.fill(~num, {|i|
		v=LFNoise1;a=LFNoise0;b=CombC;c=PinkNoise;d=DelayN;f=RLPF;j=[a,v];r=rrand(0.5, 2.0);w=rrand(2.01, 4.01);

		e=b.ar((c.ar()*j.choose.kr(1,0.2,0.85)).pow(3)+d.ar(~buses[i],4.1,j.choose.kr(v.kr(0.5,r,w),0.1,0.1)),1,
		j.choose.kr(j.choose.kr(0.5,r,w),1,0).abs);

		h=f.ar(e,j.choose.kr(j.choose.kr(0.5,r,w),rrand(500, 10000),rrand(500, 10000)),j.choose.kr(j.choose.kr(1,0.4,0.4),0.09,0.1));

		Out.ar(~buses[i],h);
		LeakDC.ar(h).clip;
	});

	g.postln;

	LeakDC.ar(Splay.ar(g ,1));
};

)



//ASSAULTS #30, 31, 32 :

(
~num = 4;
~buses = Array.fill(~num, {Bus.audio(s,1)});
play{	g = Array.fill(~num, {|i|
		v=LFNoise1;a=LFNoise0;b=CombC;c=PinkNoise;d=DelayN;f=RLPF;j=[a,v];r=rrand(0.5, 2.0);
		w=rrand(2.01, 4.01);
        e=b.ar((c.ar()*j.choose.kr(1,0.2,0.85)).pow(4)+d.ar(~buses[i],0.2,j.choose.kr(v.kr(0.5,r,w),0.1,0.1)),1,j.choose.kr(j.choose.kr(0.5,r,w),1,0).abs);
        h=f.ar(e,j.choose.kr(j.choose.kr(0.5,r,w),10000,10000),j.choose.kr(j.choose.kr(1,0.4,0.4),0.09,0.1));
		Out.ar(~buses[i],h);
		LeakDC.ar(h).clip;
	});
	g.postln;
	LeakDC.ar(Splay.ar(g ,1));
};
)




//ASSAULT #28,29 : stereo

(

play{

	a=LFNoise0;b=CombC;c=PinkNoise;d=DelayN;f=RLPF;v=LFNoise1;
	r=1; w=2;
	e=b.ar((c.ar()*a.kr(1,0.2,0.85)).pow(4) +d.ar(LocalIn.ar(2),0.2,a.kr(v.kr(0.5,r,w),0.1,0.1)),1,
		a.kr(v.kr(0.5,r,w),1,0).abs);
	b=b.ar(e,1,a.kr(v.kr(0.5,r,w),0.2,0.2).abs);
	g=f.ar(b,a.kr(v.kr(0.5,r,w),10000,10000),a.kr(v.kr(1,0.4,0.4),0.09,0.1));
	h=f.ar(e,a.kr(v.kr(0.5,r,w),10000,10000),a.kr(v.kr(1,0.4,0.4),0.09,0.1));
	     LocalOut.ar([g,h]);
	LeakDC.ar([g,h]).clip;
};

)


//ASSAULT #25,26,27 : stereo

(

play{

	a=LFNoise0;b=CombC;c=PinkNoise;d=DelayN;f=RLPF;v=LFNoise1;
	r=1; w=2;
	e=b.ar((c.ar()*a.kr(1,0.2,0.85)).pow(4) +d.ar(LocalIn.ar(2),0.2,a.kr(v.kr(0.5,r,w),0.1,0.1)),1,
		a.kr(v.kr(0.5,r,w),1,0).abs);
	b=b.ar(e,1,a.kr(v.kr(0.5,r,w),0.2,0.2).abs);
	g=f.ar(b,a.kr(v.kr(0.5,r,w),10000,10000),a.kr(v.kr(1,0.4,0.4),0.09,0.1));
	h=f.ar(e,a.kr(v.kr(0.5,r,w),10000,10000),a.kr(v.kr(1,0.4,0.4),0.09,0.1));
	     LocalOut.ar([g,h]);
	[g,h].clip;
};

)


//ASSAULTS #22-24: a birthday present for The Kane
(
play{a=LFNoise0; b=CombC.ar((PinkNoise.ar() * a.kr(1,0.2,1)) + DelayN.ar(LocalIn.ar(1), 0.2,a.kr(5,0.1,0.1)),1, a.kr(5,1,0).abs); c=RLPF.ar(b,a.kr(5,10000,10000), 0.1); LocalOut.ar(c); (c!2).clip;};
)


//ASSAULT #21

// V2
(
play{
	var num = rrand(4,12);
	num.postln;
	a = LFNoise0;
	c = Array.fill(num, {var val = rrand(0.5, 6.0);
		a.kr(rrand(0.5,1.0),val/2.01, val) });
	b = Impulse.ar(c);
	p=Pulse.ar(RunningMax.ar(Sweep.ar(LocalIn.ar(num))));
	o=SinOsc.ar(1/RunningMax.ar(Sweep.ar(p.clip)*p.tanh%p,b.tanh%2pi,p%1))*2;
	LocalOut.ar(o.clip + CombC.ar((o),12,Mix(c),Mix(c),2));
	Splay.ar(o).tanh/2;
}
)

// V1
(
play{
	var num = rrand(4,12);
	num.postln;
	a = LFNoise0;
	c = Array.fill(num, {var val = rrand(0.5, 6.0);
		a.kr(rrand(0.5,1.0),val/2.01, val) });
	b = Impulse.ar(c);
	p=Pulse.ar(RunningMax.ar(Sweep.ar(LocalIn.ar(num))));
	o=SinOsc.ar(1/RunningMax.ar(Sweep.ar(p.clip)*b.tanh%b,b.tanh%2pi,p%1))*2;
	LocalOut.ar(o.clip + CombC.ar((o),12,Mix(c),Mix(c),2));
	Splay.ar(o).tanh/2;
}
)


//ASSAULT #20

(
play{var num = rrand(9,18); num.postln; a = LFNoise0; d =  c = Array.fill(num, {var val = rrand(0.5, 6.0); a.kr(rrand(0.5,1.0),val/2.01, val) }); b = Impulse.ar(c); o=SinOsc.ar(1/RunningMax.ar(Sweep.ar(LocalIn.ar(num).clip),b)); LocalOut.ar(o); Splay.ar(o).tanh/2;
}
)

//based on this code found on the nabble supercollider list

play{o=SinOsc.ar(1/RunningMax.ar(Sweep.ar(LocalIn.ar(6)),Impulse.ar([1,0.749,6,12,3,4]))); LocalOut.ar(o); Splay.ar(o).tanh/2} //#SuperCollider




// ASSAULT 15 .. 19
s.makeGui

(

5.do({|i|

	var name = ("assault13"++i).asString.postln;
name.postln;
name.isString.postln;


SynthDef(name, {

	var lfn, lfo, mod, modC, osc, fltr1, fltr2, rizzultz, modAry, op, vl, rs, rv, modAryV, rv2, lf1, lf2, md, os, os2, fl;

lfn = [LFNoise0, LFNoise1, LFNoise2, LFDNoise0, LFDNoise1, LFDNoise3];
lfo = [LFCub, LFPar, LFTri, LFSaw, Impulse];
mod = [SinOsc];
modC = [HenonN];
osc = [SinOsc];
fltr1 = [LPF, HPF];
fltr2 = [BPF, BRF, RLPF, RHPF];


	modAry = Array.fill(4, {[[rrand(0.1, 5), rrand(50, 100), rrand(50, 100)],
		[rrand(0.1, 5), rrand(100, 400), rrand(100, 400)],
		[rrand(0.1, 15), rrand(500, 1500), rrand(500, 1500)],
		[rrand(0.1, 2), rrand(2000, 5000), rrand(2000, 5000)]].choose});

	op = ['+', '*', '-'];
	vl = 400;
	rs = Array.fill(10,
		{
		[[rrand(0.1, 5), rrand(1, 5), rrand(3, 8)],
		[rrand(5, 50), rrand(1, 5), rrand(3, 8)],
		[rrand(0.1, 5), rrand(5, 10), rrand(6, 11)],
		[rrand(5,25), rrand(5, 10), rrand(6, 11)],
		[rrand(0.1, 5), rrand(50, 100), rrand(50, 100)],
		[rrand(0.1, 5), rrand(100, 400), rrand(100, 400)],
		[rrand(0.1, 15), rrand(500, 1500), rrand(500, 1500)],
		[rrand(0.1, 2), rrand(2000, 5000), rrand(2000, 5000)]
		].choose;
		}
	);

	rv = rs.choose;
	rv2 = rs.choose;
	modAryV = modAry.choose;

	lf1 = [lfn, lfo].choose;
	if(lf1 == lfn, {lf1 = lf1.choose.kr(rv[0],rv[1], rv[2])},
		{lf1 = lf1.choose.ar(rv[0],rv[1]%pi, rv[2]%1)});

	lf2 = [lfn, lfo].choose;
	if(lf2 == lfn, {lf2 = lf2.choose.kr(rv2[0],rv2[1], rv2[2])},
		{lf2 = lf2.choose.ar(rv2[0],rv2[1]%pi, rv2[2]%1)});


	md = [mod, modC].choose;
	if(md == mod, {"true = md".postln; md = mod.choose.ar(modAryV[0],modAryV[1], modAryV[2])},
	{"false = md".postln; md = mod.choose.ar(modAryV[0],modAryV[1]%pi, modAryV[2]%1)});

	"os reached".postln;

	os = osc.choose.ar(op.choose.applyTo(lf1, lf2), md%pi, lf2);
	os2 = osc.choose.ar(op.choose.applyTo((os + md ),os));

	"rizzultz reached".postln;
	rizzultz = Normalizer.ar(os + os2);

		Out.ar([0,1],rizzultz);

}).add;

});

)

Synth.new("assault130");
Synth.new("assault131");
Synth.new("assault132");
Synth.new("assault133");
Synth.new("assault134");

//SynthDescLib.at(\assault130).def.func.postcs; "";

Server.default.makeGui







// PulseULator
// pulse waves = ear damage.  Plz turn up and apply direcly to ears
// sweet spots around 2.7k, 3.7k, 4.7k,  7k, rq=0

// PULSES

// ASSAULT 1
(
{
	var snd = Pulse.ar(4)+Pulse.ar(8)+Pulse.ar(16)+Pulse.ar(2);
	var filt = RHPF.ar(snd, EnvGen.kr(Env([16000,50,50],[25,5],\exponential),1, doneAction:2), 0.001);
	Pan2.ar(snd + filt);
}.play
)


// ASSAULT 2

(
{
	var env1 = EnvGen.kr(Env([1,16000, 1],[12.5, 12.5],\linear),1, doneAction:2);
	var env2 = EnvGen.kr(Env([500,2, 1200],[12.5,12.5],\linear),1);
	var env3 = EnvGen.kr(Env([5000,50, 5000],[12.5, 12.5],\linear),1);
	var env4 = EnvGen.kr(Env([15000,5000, 15000],[12.5, 12.5],\linear),1);
	var env5 = EnvGen.kr(Env([1,1,0],[24.99, 0.01],\linear),1);
	var snd = Pulse.ar(env1)+Pulse.ar(env2)+Pulse.ar(env3)+Pulse.ar(env4); var filt = RHPF.ar(snd, env4, 0.001);

	Pan2.ar(snd + filt)* env5;
}.play
)


// ASSAULT 3

(
{
	var env1 = EnvGen.kr(Env([1,5,20,20,51,5050],[20,15,10,5,5],\linear),1);
	var env2 = EnvGen.kr(Env([1,10,20,30,52,5100],[20,15,10,5,5],\linear),1);
	var env3 = EnvGen.kr(Env([1,15,20,40,53,5500],[20,15,10,5,5],\linear),1);
	var env4 = EnvGen.kr(Env([1,20,20,50,54,6000],[20,15,10,5,5],\linear),1);
	var env5 = EnvGen.kr(Env([1,1,0],[60.99, 0.01],\linear),1, doneAction:2);
	var snd = Pulse.ar(env1)+Pulse.ar(env2)+Pulse.ar(env3)+Pulse.ar(env4);
	Pan2.ar(snd)* env5 ;
}.play
)

// ASSAULT 4

(
{
	var mod1 = LFNoise1.kr(LFNoise0.kr(0.5, 0.5, 0.6), 20, 40);
	var mod2 = LFNoise1.kr(LFNoise0.kr(0.5, 0.5, 0.6), 20, 40);
	var mod3 = LFNoise1.kr(LFNoise0.kr(0.5, 0.5, 0.6), 20, 40);
	var sig1 = Pulse.ar(LFNoise0.kr(mod1, 400, 400),0.5,mod1)%pi;
	var sig2 = Pulse.ar(LFNoise0.kr(0.1225, 20, 21),sig1,mod2);
	var sig3 = Pulse.ar(LFNoise0.kr(0.1225, 4000, 4000),sig2,mod3);
	SinOsc.ar(sig2 * sig3, sig1, 1)!2;

}.play
)

// ASSAULT #5a - NOT USED
/*
{
	var mod1 = LFNoise1.kr(LFNoise0.kr(0.5, 0.5, 0.6), 20, 40);
	var mod2 = LFNoise1.kr(LFNoise0.kr(0.5, 0.5, 0.6), 20, 40);
	var mod3 = LFNoise1.kr(LFNoise0.kr(0.5, 0.5, 0.6), 20, 40);


	var sig1 = Pulse.ar(LFNoise1.kr(0.1225, 400, 400),0.5,mod1)%pi;
	var sig2 = Pulse.ar(LFNoise1.kr(0.1225, 40, 0),sig1,mod2);
	var sig3 = Pulse.ar(LFNoise1.kr(0.1225, 4000, 4000),sig2,mod3);

	SinOsc.ar(sig2 * sig3, sig1, 1)!2;

}.play


// ASSAULT #5B - NOT USED

(
{
	var mod1 = EnvGen.kr(Env([1,5,20,30,51,5050],[20,15,10,5,15],\linear),1);
	var mod2 = EnvGen.kr(Env([5,1,20,20,1,5050],[20,15,10,5,15],\linear),1);

	var sig1 = Pulse.ar(LFNoise0.kr(mod1, 40, 0), mod1%1, mod1%50);
	var sig2 = Pulse.ar(LFNoise0.kr(mod2, 4000, 4000), sig1%1 , mod2%50);

	var snd = SinOsc.ar(sig1 * sig2, sig1%pi, 1)!2;
	snd = Normalizer.ar(snd,1);

}.play
)
*/


// ASSAULT #5(c)

(
{
	var mod1 = LFNoise1.kr(LFNoise1.kr(0.5, 0.5, 0.6), 25, 25);
	var mod2 = LFNoise1.kr(LFNoise1.kr(0.5, 0.5, 0.6), 25, 25);
	var sig1 = Pulse.ar(LFNoise0.kr(mod1, 40, 0), mod1%1, mod1);
	var sig2 = Pulse.ar(LFNoise0.kr(mod2, 4000, 4000), sig1%1 , mod2);
	var snd = SinOsc.ar(sig1 * sig2, sig1%pi, 1)!2;
	snd = Normalizer.ar(snd,1);
}.play
)



/*_____________________________________________________________

SECOND SET
_____________________________________________________________*/



// ASSAULT 6 -- can you smell what I'm laying down?!?
// *recorded on #! Dell - orig file .loca/share/SuperCollider/Recordings

(
{
	var env1 = EnvGen.kr(Env([4000,0.01, 0.01], [25,15]), doneAction:2);
	var mod1a = LFNoise1.kr(LFNoise0.kr(0.235, 4.57, 6), 37, 41);
	var mod1b = LFNoise1.kr(LFNoise0.kr(0.75, 3.76, 6.79), 29, 40);
	var mod2 = LFNoise1.kr(LFNoise0.kr(0.35, 5, 6), 20, 40);
	var mod3 = LFNoise1.kr(LFNoise0.kr(0.45, 0.5, 0.6), 20, 40);
	var sig1a = SinOsc.ar(LFNoise1.kr(0.1225, 0.01, env1), 0, mod1a.tan);
	var sig1b = SinOsc.ar(LFNoise1.kr(0.579, 0.01, env1), 0, mod1b.tan);
	var sig2 = SinOsc.ar(LFNoise1.kr(0.375, 0.05, 0),sig1a % pi, mod2);
	var sig3 = SinOsc.ar(LFNoise1.kr(0.445, 0.05, 0),sig1b % pi, mod3);
	var snd1 = Pan2.ar(SinOsc.ar(sig2.tanh * sig3, sig1a, mod1a), mod1a.linlin(04,78, -0.8,0.8));
	var snd2 = Pan2.ar(SinOsc.ar(sig3.tanh + sig2, sig1b, mod1b), mod1b.linlin(11,69, -0.8,0.8));
	Out.ar(0, Limiter.ar(snd1 + snd2));
}.play
)



// ASSAULT 7a -- not used

/*
(
{
	var eF = [1,3000,5000,9000,11000,17000].scramble;
	var eF1 = Array.newFrom(eF).add(0);
	var eF2 = Array.newFrom(eF).scramble.add(0);

	var eT = [3,5,7,9,11].scramble;
	var eT1 = Array.newFrom(eT).add(1);
	var eT2 = Array.newFrom(eT).scramble.add(1);

	var env1 = EnvGen.kr(Env(eF1, eT1), doneAction:2);
	var env2 = EnvGen.kr(Env(eF2, eT2), doneAction:2);

	var mod1a = LFNoise1.kr(LFNoise1.kr(0.235, 4.57, 6), 37, 41);
	var mod1b = LFNoise1.kr(LFNoise1.kr(0.75, 3.76, 6.79), 29, 40);
	var mod2 = LFNoise1.kr(LFNoise1.kr(0.35, 5, 6), 20, 40);
	var mod3 = LFNoise1.kr(LFNoise1.kr(0.45, 0.5, 0.6), 20, 40);

	var sig1a = SinOsc.ar(LFNoise1.kr(0.1225, 0.01, env1), 0, mod1a);
	var sig1b = SinOsc.ar(LFNoise1.kr(0.579, 0.01, env2), 0, mod1b);

	var sig2 = SinOsc.ar(LFNoise1.kr(0.375, 0.05, 0),sig1a % pi, mod2.sinh);
	var sig3 = SinOsc.ar(LFNoise1.kr(0.445, 0.05, 0),sig1b % pi, mod3.sinh);

	var snd1 = Pan2.ar(SinOsc.ar(sig2.cosh * sig3.acos, sig1a, mod1a), mod1a.linlin(04,78, -0.8,0.8));
	var snd2 = Pan2.ar(SinOsc.ar(sig3.atan + sig2.sinh, sig1b, mod1b), mod1b.linlin(11,69, -0.8,0.8));

	Out.ar(0, Limiter.ar(snd1 + snd2));

}.play
)
*/



// ASSAULT 7b --

(
{	var eF1 = [0.01,5000,5100,2000,2050,7200,7000,100,50,0.01];
	var eF2 = [0.01,5100,5000,2050,2000,7000,7200,50,100,0.01];
	var eT1 = [5,3,5,2,3,7,3,7,1];
	var env1 = EnvGen.kr(Env(eF1, eT1, \exponential), doneAction:2);
	var env2 = EnvGen.kr(Env(eF2, eT1, \exponential), doneAction:2);
	var mod1a = LFNoise1.kr(LFNoise1.kr(0.235, 4.57, 6), 37, 41);
	var mod1b = LFNoise1.kr(LFNoise1.kr(0.75, 3.76, 6.79), 29, 40);
	var mod2 = LFNoise1.kr(LFNoise1.kr(0.35, 5, 6), 20, 40);
	var mod3 = LFNoise1.kr(LFNoise1.kr(0.45, 0.5, 0.6), 20, 40);
	var sig1a = SinOsc.ar(LFNoise1.kr(0.1225, 0.01, env1), 0, mod1a);
	var sig1b = SinOsc.ar(LFNoise1.kr(0.579, 0.01, env2), 0, mod1b);
	var sig2 = SinOsc.ar(LFNoise1.kr(0.375, 0.05, 0),sig1a % pi, mod2.sinh);
	var sig3 = SinOsc.ar(LFNoise1.kr(0.445, 0.05, 0),sig1b % pi, mod3.sinh);
	var snd1 = Pan2.ar(SinOsc.ar(sig2.cosh * sig3.acos, sig1a, mod1a), mod1a.linlin(04,78, -0.8,0.8));
	var snd2 = Pan2.ar(SinOsc.ar(sig3.atan + sig2.sinh, sig1b, mod1b), mod1b.linlin(11,69, -0.8,0.8));
	Out.ar(0, Limiter.ar(snd1 + snd2));}.play
)




// ASSAULT 8


(
{
	var eF1 = [5000,5010];
	var eF2 = [5010,5000];
	var eT1 = [45];
	var env1 = EnvGen.kr(Env(eF1, eT1, \linear), doneAction:2);
	var env2 = EnvGen.kr(Env(eF2, eT1, \linear), doneAction:2);
	var mod1a = LFNoise0.kr(LFNoise0.kr(5, 4.57, 6), 37, 41);
	var mod1b = LFNoise0.kr(LFNoise0.kr(7, 3.76, 6.79), 29, 40);
	var mod2 = LFNoise0.kr(LFNoise0.kr(3, 5, 6), mod1a, mod1b);
	var mod3 = LFNoise0.kr(LFNoise0.kr(4, 0.5, 0.6), mod1b, mod2);
	var sig1a = SinOsc.ar(LFNoise0.kr(1, 0.01, env1), mod2%pi, mod1a);
	var sig1b = SinOsc.ar(LFNoise0.kr(6, 0.01, env2), mod1a%pi, mod1b);
	var sig2 = SinOsc.ar(LFNoise0.kr(3, 0.05, 0).cos,sig1a % pi, mod2.sinh);
	var sig3 = SinOsc.ar(LFNoise0.kr(5, 0.05, 0).tan,sig1b % pi, mod3.sinh);
	var snd1 = Pan2.ar(SinOsc.ar(sig2.cosh * sig3.acos, sig1a.tanh%pi, mod1a), mod1a.linlin(04,78, -0.8,0.8));
	var snd2 = Pan2.ar(SinOsc.ar(sig3.atan + sig2.sinh, sig1b.cos%pi, mod1b), mod1b.linlin(11,69, -0.8,0.8));
	Out.ar(0, Limiter.ar(snd1 + snd2));}.play
)


// ASSAULT 9


(
{
	var mod = LFNoise2.kr(500);
	var snd = SinOscFB.ar(400.pow(mod) * mod.tanh + mod.cos, mod%pi);
	snd = Compander.ar(snd,snd,1,1,0.01,0.01);
	Out.ar(0, snd!2);
}.play
)


// ASSAULT 10

(
{   var num = 5;
	var array = Array.fill(num, {|i|
		var frac = 2 / num;
		var mod = LFNoise2.kr(Rand(1,50));
		var snd = SinOscFB.ar(rrand(4, 400).pow(mod) * mod.tanh + mod.cos, mod%pi);
		Pan2.ar(Compander.ar(snd,snd, rrand(0.01,1), rrand(0.01,1),rrand(0.01,1), rrand(0.01, 1), rrand(0.01, 1)), 2 - (frac * i));
	});

	Out.ar(0, Mix(array));
}.play
)





/*_____________________________________________________________

THIRD SET
_____________________________________________________________*/

// ignore this bit - it's just for recording options when I'm exporting to the web
s.options.sampleRate = 48000;
s.options.memSize = 4096 * 5;
s.recHeaderFormat = "aiff";
s.recSampleFormat = "int24";
s.recChannels = 2;
s.reboot;
s.makeGui;




// ASSAULT 11 ... 14
s.makeGui

(
x = {

	var lfn, lfo, mod, osc, fltr1, fltr2, rizzultz, fr, op, vl, rs, rv, frv, rv2, lf1, lf2, md, os, os2, fl;

lfn = [LFNoise0, LFNoise1, LFNoise2, LFDNoise0, LFDNoise1, LFDNoise3];
lfo = [LFCub, LFPar, LFTri, LFSaw, Impulse];
mod = [SinOsc];
osc = [SinOsc];
fltr1 = [LPF, HPF];
fltr2 = [BPF, BRF, RLPF, RHPF];


	fr = Array.fill(4, {[[rrand(0.1, 5), rrand(50, 100), rrand(50, 100)],
		[rrand(0.1, 5), rrand(100, 400), rrand(100, 400)],
		[rrand(0.1, 15), rrand(500, 1500), rrand(500, 1500)],
		[rrand(0.1, 2), rrand(2000, 5000), rrand(2000, 5000)]].choose});

	op = ['+', '*'];
	vl = 400;
	rs = Array.fill(10,
		{
		[[rrand(0.1, 5), rrand(1, 5), rrand(3, 8)],
		[rrand(5, 50), rrand(1, 5), rrand(3, 8)],
		[rrand(0.1, 5), rrand(5, 10), rrand(6, 11)],
		[rrand(5,25), rrand(5, 10), rrand(6, 11)],
		[rrand(0.1, 5), rrand(50, 100), rrand(50, 100)],
		[rrand(0.1, 5), rrand(100, 400), rrand(100, 400)],
		[rrand(0.1, 15), rrand(500, 1500), rrand(500, 1500)],
		[rrand(0.1, 2), rrand(2000, 5000), rrand(2000, 5000)]
		].choose;
		}
	);

	rv = rs.choose;
	rv2 = rs.choose;
	frv = fr.choose;

	lf1 = [lfn, lfo].choose;
	if(lf1 == lfn, {lf1 = lf1.choose.kr(rv[0],rv[1], rv[2])},
		{lf1 = lf1.choose.ar(rv[0],rv[1]%pi, rv[2]%1)});

	lf2 = [lfn, lfo].choose;
	if(lf2 == lfn, {lf2 = lf2.choose.kr(rv2[0],rv2[1], rv2[2])},
		{lf2 = lf2.choose.ar(rv2[0],rv2[1]%pi, rv2[2]%1)});


	md = mod;
	if(md == mod, {md = mod.choose.ar(frv[0],frv[1], frv[2])},
	{md = mod.choose.ar(frv[0],frv[1]%pi, frv[2]%1)});


	os = osc.choose.ar(op.choose.applyTo(lf1, lf2), md%pi, lf2);
	os2 = osc.choose.ar(op.choose.applyTo((os + md ),os));

	rizzultz = Normalizer.ar(os + os2);

	rizzultz;

};


10.do({|i| x.asSynthDef(name:"eff"++i).add; });

)


Synth.new("eff0");
Synth.new("eff1");
Synth.new("eff2");
Synth.new("eff3");
Synth.new("eff4");
Synth.new("eff5");
Synth.new("eff6");
Synth.new("eff7");
Synth.new("eff8");
Synth.new("eff9");




/*
FOR TESTING THE ABOVE ALGORITHM


SynthDescLib.global.synthDescs.do { |desc|
        if(desc.def.notNil) {
                "\nSynthDef %\n".postf(desc.name.asCompileString);
                desc.def.func.postcs;
        };
};
""  // this prevents the synthDescs collection from posting

SynthDescLib.at(eff0).def.func.postcs; "";

*/
































// TESTING CRAP BELOW!  IGNORE!!  IGNOOOOORE!!!
4 ~bin.asInteger 7

~bin = ['*','+'].choose.applyTo(vl, lf)


	~rs = Array.fill(10,
		{
		[[rrand(0.1, 5), rrand(1, 5), rrand(3, 8)],
		[rrand(5, 50), rrand(1, 5), rrand(3, 8)],
		[rrand(0.1, 5), rrand(5, 10), rrand(6, 11)],
		[rrand(5,25), rrand(5, 10), rrand(6, 11)],
		[rrand(0.1, 5), rrand(50, 100), rrand(50, 100)],
		[rrand(0.1, 5), rrand(100, 400), rrand(100, 400)],
		[rrand(0.1, 15), rrand(500, 1500), rrand(500, 1500)],
		[rrand(0.1, 2), rrand(2000, 5000), rrand(2000, 5000)]
		].choose;
		}
	);

~lo = ~rs.choose.asString
~lo.isString
~li = "("++~lo++")"




























