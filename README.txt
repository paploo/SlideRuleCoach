SlideRuleCoach
Copyright (c) 2011, Jeffrey C. Reinecke
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.
* Neither the name of the copyright holders nor the
names of its contributors may be used to endorse or promote products
derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL JEFFREY REINECKE BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Contact:
www.github.com/paploo/SlideRuleCoach
jeff@paploo.net

Overview:

A simple iPhone application to generate problems to practice using a slide rule.

Todo List:
[ ] Add License text to all files.

[ ] Build out Problem Generators:
    [ ] Basic:
        [+] Multiplication (a*b*c)
        [+] Inversion (1/a)
        [+] Fractions (a*c*e/b*d*f)
        [ ] Ratio-proportions
    [+] Squares, Cubes and Roots:
        [+] Squares (b^2)
        [+] Cubes (b^3)
        [+] Roots (sqrt(b), croot(b))
        [+] A-B Scales Squares (a*b^2)
    [+] Powers and Logs:
        [+] 10^x
        [+] log10(x)
        [+] x^n
        [+] logn(x) [Note: need to build custom random number for difficulty implementations to keep in range; use same one for exponents.]
    [ ] Trig:
        [ ] x degrees in radians
        [ ] x radians in degrees
        [ ] sin(x), x in [5.7392, 90]
        [ ] cos(x), x in [0, 84.2608]
        [ ] tan(x), x in [5.7106, 89.4270]  Note: Should break at 45 as well?
        [ ] sin(x), x in [0.5730, 5.27392]
        [ ] cos(x), x in [84.2608, 89.4270] Note: Most rules aren't marked for this?
        [ ] tan(x), x in [0.5729, 5.7106]
    [ ] Special:
        [ ] Hyperbolic Trig functions?
        [ ] Artillary Ranging.
        [ ] RandomProblemGenerator: Initialized with an array of problem generators, and then randomly selects from them.  Weights?


[ ] ScaleConverter: Class methods for paramaterization of scales and back.
    [ ] mainScaleValueForParameter:
    [ ] mainScaleParameterForValue:
    [ ] powerScaleValueForParameter:power: //Delegate to main scale value, used for A,B,K.
    [ ] powerSvaleParameterForValue:power: //Delegate to main scale value, used for A,B,K.
    [ ] logScaleValueForParameter: //L scale
    [ ] logScaleValueForParameter: //L scale
    [ ] logLogScaleValueForParameter: //LL scale
    [ ] logLogScaleParameterForValue: //LL scale
    [ ] sinScaleValueForParameter:
    [ ] sinScaleParameterForValue:
    [ ] cosScaleValueForParameter: //Delegate to sin scale
    [ ] cosScaleParameterForValue: //Delegate to sin scale
    [ ] tanScaleValueForParameter:
    [ ] tanScaleParameterForValue:

[ ] Problem Timer
    [ ] Record timer data.
    [ ] Show running timer before submitting.
    [ ] Show average time.

[ ] Problem Formatting
    [ ] Replace the equation display with a UIWebView.
