//
//  RandomNumberGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/17/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
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

@end
