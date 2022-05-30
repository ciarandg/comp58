/*
 * Comp58 is a vocal effects chain that I use on my SM58 to increase
 * line level and add some compression for use in Zoom, Discord, etc
*/

import("stdfaust.lib");

noiseGate = hgroup("Noise Gate",
                   ef.gate_mono(hslider("Threshold",-60,-60,0,1),
                                0.002, 0.3, 0.02));
gainMultiplier = hslider("Gain",2,1,25,0.1);
compressor = hgroup("Compressor",
                    co.compressor_mono(hslider("Ratio",8,1,10,0.1),
                                       hslider("Threshold",-10,-60,0,1),
                                       0.02, 0.02));

effectChain = noiseGate : *(gainMultiplier) : compressor;

inMeter = hgroup("Volume",attach(_,abs : ba.linear2db : hbargraph("Input",-60,0)));
outMeter = hgroup("Volume",attach(_,abs : ba.linear2db : hbargraph("Output",-60,0)));

process = effectChain <: outMeter;
