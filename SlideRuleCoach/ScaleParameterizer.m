//
//  ScaleParameterizer.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/26/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import "ScaleParameterizer.h"
#import "Trig.h"


@implementation ScaleParameterizer

// C or D scale
+ (double)mainScaleValueForParameter:(double)u {
    return pow(10.0, u);
}

// C or D scale
+ (double)mainScaleParameterForValue:(double)v {
    return log10(fabs(v));
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
    return log10(log(fabs(v)));
}

// S and ST scale.
+ (double)sinScaleValueForParameter:(double)u {
    if(u <= 0.0) {
        return [self mainScaleValueForParameter:u] * ONE_TENTH_RADIAN_IN_DEGREE;
    } else if( (u >= 0.0) && u <=1.0) {
        double s = [self mainScaleValueForParameter:u] / 10.0;
        return asin(s) * DEGREE_TO_RADIAN;
    } else {
        NSException *e = [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"Cannot calculate sin scale angle for parameter %f", u] userInfo:nil];
        [e raise];
        return 0.0;
    }
}

// S and ST scale.
+ (double)sinScaleParameterForValue:(double)v {
    //First get the value (which is in degrees) into the appropriate range (0-90)
    double value = asin(fabs(sin(v*DEGREE_TO_RADIAN))) * RADIAN_TO_DEGREE;
    
    //Now we can calculate the paramaterized value.
    if( (value > 0.0) && (value <= ONE_TENTH_RADIAN_IN_DEGREE) ) {
        return [self mainScaleParameterForValue:(value / ONE_TENTH_RADIAN_IN_DEGREE)];
    } else if( (value >= ONE_TENTH_RADIAN_IN_DEGREE) && (value <= 90.0) ) {
        double s = sin(value*DEGREE_TO_RADIAN);
        return [self mainScaleParameterForValue:(s*10.0)];
    } else {
        NSException *e = [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"Cannot calculate sin scale parameter for angle %f", v] userInfo:nil];
        [e raise];
    }
    
    return 0.0; // This is to silence the compiler warnings.
}

+ (double)cosScaleValueForParameter:(double)u {
    return 90.0 - [self sinScaleValueForParameter:u];
}

+ (double)cosScaleParameterForValue:(double)v {
    return [self sinScaleParameterForValue:(90.0 - v)];
}

// T and ST scale.
// This returns values only under 45 degrees because of how the T scale folds.
+ (double)tanScaleValueForParameter:(double)u {
    if( u <= 0.0 ) {
        return [self mainScaleParameterForValue:u] * ONE_TENTH_RADIAN_IN_DEGREE;
    } else if( (u >= 0.0) &&  (u <= 1.0) ) {
        double t = [self mainScaleValueForParameter:u] / 10.0;
        return atan(t) * DEGREE_TO_RADIAN;
    } else {
        NSException *e = [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"Cannot calculate sin scale angle for parameter %f", u] userInfo:nil];
        [e raise]; 
    }
            
    return 0.0;
}

// T and ST scale.
// The T scale folds on top of itself for values over 45 degrees.
+ (double)tanScaleParameterForValue:(double)v {
    //First get the value (which is in degrees) into the appropriate range (0-90)
    double value = atan(fabs(tan(v*DEGREE_TO_RADIAN))) * RADIAN_TO_DEGREE;
    
    //Now we can calculate the paramaterized value.
    if( (value > 0.0) && (value <= ONE_TENTH_RADIAN_IN_DEGREE) ) {
        return [self mainScaleParameterForValue:(value / ONE_TENTH_RADIAN_IN_DEGREE)];
    } else if( (value >= ONE_TENTH_RADIAN_IN_DEGREE) && (value <= 45.0) ) {
        double t = sin(value*DEGREE_TO_RADIAN);
        return [self mainScaleParameterForValue:(t*10.0)];
    } else if( (value >= 45.0) && (value < 90.0) ) {
        return [self tanScaleParameterForValue:(90.0 - v)];
    } else {
        NSException *e = [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"Cannot calculate tan scale parameter for angle %f", v] userInfo:nil];
        [e raise];
    }
    
    return 0.0; // This is to silence the compiler warnings.
}

@end
