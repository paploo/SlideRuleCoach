//
//  RandomNumberGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "stdlib.h"

#import "RandomNumberGenerator.h"


@implementation RandomNumberGenerator

+ (void)randomize {
    // Calling both is probably redundant.
    //srandom(time(NULL));
    srandomdev();
    srand(time(NULL));
}

+ (NSNumber *)integerWithMin:(NSInteger)min max:(NSInteger)max {
    NSInteger delta = max - min + 1;
    NSInteger offset = min;
    NSInteger rand = (random() % delta) + offset;
    return [NSNumber numberWithLong:rand];
}

+ (NSNumber *)decimal {
    //double rand = (random() % RAND_MAX) / ((double)RAND_MAX);
    double rand = (double)random() / (double)RAND_MAX;
    return [NSNumber numberWithDouble:rand];
}

+ (NSNumber *)decimalWithMin:(double)min max:(double)max {
    double delta = max - min;
    double offset = min;
    double rand = ([[self decimal] doubleValue] * delta) + offset;
    return [NSNumber numberWithDouble:rand];
}

+ (NSNumber *)decimalWithMinPower:(NSInteger)min maxPower:(NSInteger)max canBeNegative:(BOOL)canBeNeg{
    NSInteger mantissa = [[self integerWithMin:1000 max:10000] intValue];
    NSInteger exponent = [[self integerWithMin:min max:max] intValue];
    BOOL neg = NO;
    if( canBeNeg )
        neg = [[self bool] boolValue];
    
    NSNumber *rand = [[NSDecimalNumber alloc] initWithMantissa:mantissa exponent:(exponent-3) isNegative:neg];
    return [rand autorelease];
}

+ (NSNumber *)decimalWithDifficulty:(ProblemDifficulty)difficulty {
    return [self decimalWithMinPower:-1.0 maxPower:1.0 canBeNegative:NO];
}

+ (NSNumber *)bool {
    return [self boolWithProbability:0.50];
}

+ (NSNumber *)boolWithProbability:(double)prob {
    double result = [[self decimal] doubleValue];
    if( result < prob )
        return [NSNumber numberWithBool:YES];
    else
        return [NSNumber numberWithBool:NO];
}

@end
