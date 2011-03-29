//
//  RandomNumberGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/17/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import <stdlib.h>
#import <math.h>

#import "RandomNumberGenerator.h"
#import "ScaleParameterizer.h"
#import "trig.h"

// This is used for easier difficulties of LL scale problems.
const double commonBases[] = {1/M_E, 0.5, M_E, 2.0, 8.0, 10.0};

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
        neg = [self bool];
    
    NSNumber *rand = [[NSDecimalNumber alloc] initWithMantissa:mantissa exponent:(exponent-3) isNegative:neg];
    return [rand autorelease];
}

+ (NSNumber *)decimalWithDifficulty:(ProblemDifficulty)difficulty {
    NSNumber *rand;
    
    switch(difficulty) {
        case ProblemDifficultyIntroductory:
            rand = [self decimalWithMinPower:0.0 maxPower:0.0 canBeNegative:NO];
            break;
        case ProblemDifficultyEasy:
            rand = [self decimalWithMinPower:0.0 maxPower:1.0 canBeNegative:NO];
            break;
        case ProblemDifficultyNormal:
            rand = [self decimalWithMinPower:-1.0 maxPower:1.0 canBeNegative:NO];
            break;
        case ProblemDifficultyAdvanced:
            rand = [self decimalWithMinPower:-3.0 maxPower:3.0 canBeNegative:NO];
            break;
        case ProblemDifficultyMaster:
            rand = [self decimalWithMinPower:-6.0 maxPower:6.0 canBeNegative:NO];
            break;
    }
    
    return rand;
}

+ (BOOL)bool {
    return [self boolWithProbability:0.50];
}

+ (BOOL)boolWithProbability:(double)prob {
    double result = [[self decimal] doubleValue];
    if( result < prob )
        return YES;
    else
        return NO;
}

+ (id)randomElementFromArray:(NSArray *)array {
    NSUInteger randomIndex = (NSUInteger)(random() % [array count]);
    return [array objectAtIndex:randomIndex];
}

+ (id)randomElementFromArray:(NSArray *)array WithWeights:(NSArray *)weights {
    // First, we need to find the sum of all the weights.
    double weightSum = 0.0;
    for(NSNumber *weight in weights)
        weightSum += [weight doubleValue];
    
    // Make sure this is non-zero; otherwise return nil.
    if(weightSum <= 0.0)
        return nil;
    
    // Now we need to build a normalized cumulative total of the weights.
    NSMutableArray *cumulativeWeights = [NSMutableArray arrayWithCapacity:[weights count]];
    double accumulatedTotal = 0.0;
    for(NSNumber *weight in weights) {
        accumulatedTotal += ([weight doubleValue]/weightSum) + accumulatedTotal;
        [cumulativeWeights addObject:[NSNumber numberWithDouble:accumulatedTotal]];
    }
    
    // Now we can generate a random decimal between 0 and 1.
    NSNumber *randomDecimal = [self decimal];
    
    // Loop over the array, trying each index, until we find a value greater than or equal to the random number.
    NSUInteger index=0;
    while(index < [cumulativeWeights count]) {
        if( [randomDecimal doubleValue] >= [[cumulativeWeights objectAtIndex:index] doubleValue] )
            break;
        
        index++;
    }
    
    // Return the element found at that index.
    return [array objectAtIndex:index];
}

+ (NSNumber *)logScaleValueForDifficulty:(ProblemDifficulty)difficulty {
    // To generate evenly across a scale, we generate a u for the scale.
    double uScale; // LL3 runs from 0.0 to 1.0
    BOOL canBeInverted;//This gives a chance for it to be inverted.
    
    switch (difficulty) {
        case ProblemDifficultyIntroductory:
            uScale = [[RandomNumberGenerator decimalWithMin:0.0 max:1.0] doubleValue];
            canBeInverted = NO;
            break;
            
        case ProblemDifficultyEasy:
            uScale = [[RandomNumberGenerator decimalWithMin:0.0 max:1.0] doubleValue];
            canBeInverted = YES;
            break;
            
        case ProblemDifficultyNormal:
            uScale = [[RandomNumberGenerator decimalWithMin:-1.0 max:1.0] doubleValue];
            canBeInverted = YES;
            break;
            
        case ProblemDifficultyAdvanced:
            uScale = [[RandomNumberGenerator decimalWithMin:-2.0 max:1.0] doubleValue];
            canBeInverted = YES;
            break;
            
        case ProblemDifficultyMaster:
            uScale = [[RandomNumberGenerator decimalWithMin:-3.0 max:1.0] doubleValue];
            canBeInverted = YES;
            break;
    }
    
    double logScaleValue = [ScaleParameterizer logLogScaleValueForParameter:uScale];
    
    if( canBeInverted )
        logScaleValue = [RandomNumberGenerator bool] ? logScaleValue : 1.0/logScaleValue;
    
    return [NSNumber numberWithDouble:logScaleValue];
}

+ (NSNumber *)logBaseForDifficulty:(ProblemDifficulty)difficulty {
    // To generate evenly across a scale, we generate a u for the scale.
    double uScale; // LL3 runs from 0.0 to 1.0
    BOOL canBeInverted; //This gives a chance for it to be inverted.
    
    NSUInteger commonBaseLen = (sizeof(commonBases)/sizeof(double));
    
    switch (difficulty) {
        case ProblemDifficultyIntroductory:
            uScale = [ScaleParameterizer logLogScaleParameterForValue:(commonBases[random() % commonBaseLen])];
            canBeInverted = NO;
            break;
            
        case ProblemDifficultyEasy:
            uScale = [ScaleParameterizer logLogScaleParameterForValue:(commonBases[random() % commonBaseLen])];
            canBeInverted = NO;
            break;
            
        case ProblemDifficultyNormal:
            uScale = [[RandomNumberGenerator decimalWithMin:-1.0 max:1.0] doubleValue];
            canBeInverted = YES;
            break;
            
        case ProblemDifficultyAdvanced:
            uScale = [[RandomNumberGenerator decimalWithMin:-2.0 max:1.0] doubleValue];
            canBeInverted = YES;
            break;
            
        case ProblemDifficultyMaster:
            uScale = [[RandomNumberGenerator decimalWithMin:-3.0 max:1.0] doubleValue];
            canBeInverted = YES;
            break;
    }
    
    double base = [ScaleParameterizer logLogScaleValueForParameter:uScale];
    
    if( canBeInverted )
        base = [RandomNumberGenerator bool] ? base : 1.0/base;
    
    return [NSNumber numberWithDouble:base];
}

+ (NSNumber *)angleInDegreesForDifficulty:(ProblemDifficulty)difficulty {
    // When the ST scale is involved, we need to even up the chance.
    double maxAngle = 90.0;
    BOOL includeSTScale = YES;
    BOOL useOtherQuadrants = NO;
    
    switch(difficulty) {
        case ProblemDifficultyIntroductory:
            maxAngle = 45.0; // For Tan problems.
            includeSTScale = NO;
            break;
            
        case ProblemDifficultyEasy:
            includeSTScale = NO;
            break;
            
        case ProblemDifficultyNormal:
            break;
            
        case ProblemDifficultyAdvanced:
            includeSTScale = NO;
            useOtherQuadrants = YES;
            break;
            
        case ProblemDifficultyMaster:
            useOtherQuadrants = YES;
            break;
    }
    
    // Should se use the ST scale?
    BOOL useSTScale = includeSTScale ? [self boolWithProbability:0.25] : NO;
    
    // Generate the random number for the interval [0-90]
    NSNumber *rand = nil;
    if(useSTScale)
        rand = [self decimalWithMin:ONE_HUNDRETH_RADIAN_IN_DEGREE max:ONE_TENTH_RADIAN_IN_DEGREE];
    else
        rand = [self decimalWithMin:ONE_TENTH_RADIAN_IN_DEGREE max:maxAngle];
    
    //Now convert to another quadrant if necessary
    if( useOtherQuadrants ) {
        NSInteger quadrant = [[self integerWithMin:0 max:3] intValue];
        switch(quadrant) {
            case 0:
                // (0, 90]
                rand = rand;
                break;
            case 1:
                // [90, 180)
                rand = [NSNumber numberWithDouble:((90.0 - [rand doubleValue]) + 90.0)];
                break;
            case 2:
                rand = [NSNumber numberWithDouble:([rand doubleValue] + 180.0)];
                // (180, 270]
                break;
            case 3:
                rand = [NSNumber numberWithDouble:((90.0 - [rand doubleValue]) + 270.0)];
                // [270, 360)
                break;
        }
    }
    
    // Now we can return.
    return rand;
}

@end
