//
//  ScaleParameterizer.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScaleParameterizer.h"


@implementation ScaleParameterizer

// C or D scale
+ (double)mainScaleValueForParameter:(double)u {
    return pow(10.0, u);
}

// C or D scale
+ (double)mainScaleParameterForValue:(double)v {
    return log10(v);
}

// A/B, K, or root scales
+ (double)powerScaleValueForParameter:(double)u power:(double)p {
    return [self mainScaleValueForParameter:(u*p)];
}

// A/B, K, or root scales
+ (double)powerScaleParameterForValue:(double)v power:(double)p {
    return [self mainScaleParameterForValue:(v)] / p;
}

// L scale
+ (double)logScaleValueForParameter:(double)u {
    return u;
}

// L scale
+ (double)logScaleParameterForValue:(double)v {
    return v;
}

// LL scale
+ (double)logLogScaleValueForParameter:(double)u {
    return exp(pow(10.0, u));
}

// LL scale
+ (double)logLogScaleParameterForValue:(double)v {
    return log10(log(v));
}

// S and ST scale.
+ (double)sinScaleValueForParameter:(double)u {
#warning Incomplete implementation.
    return 0.0;
}

// S and ST scale.
+ (double)sinScaleParameterForValue:(double)v {
#warning Incomplete implementation.
    return 0.0;
}

+ (double)cosScaleValueForParameter:(double)u {
    return 90.0 - [self sinScaleValueForParameter:u];
}

+ (double)cosScaleParameterForValue:(double)v {
    return [self sinScaleParameterForValue:(90.0 - v)];
}

// T and ST scale.
+ (double)tanScaleValueForParameter:(double)u {
    //This one is tricky because of how it reflects when over 45 degrees.
#warning Incomplete implementation.
    return 0.0;
}

// T and ST scale.
+ (double)tanScaleParameterForValue:(double)v {
#warning Incomplete implementation.
    return 0.0;
}

@end
