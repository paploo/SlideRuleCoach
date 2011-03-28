//
//  RandomNumberGenerator.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/17/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import <Foundation/Foundation.h>

#import "ProblemDifficulty.h"

@interface RandomNumberGenerator : NSObject {
    
}
+ (void)randomize;
+ (NSNumber *)integerWithMin:(NSInteger)min max:(NSInteger)max;
+ (NSNumber *)decimal;
+ (NSNumber *)decimalWithMin:(double)min max:(double)max;
+ (NSNumber *)decimalWithMinPower:(NSInteger)min maxPower:(NSInteger)max canBeNegative:(BOOL)canBeNeg;
+ (NSNumber *)decimalWithDifficulty:(ProblemDifficulty)difficulty;
+ (BOOL)bool;
+ (BOOL)boolWithProbability:(double)prob;
+ (id)randomElementFromArray:(NSArray *)array;
+ (id)randomElementFromArray:(NSArray *)array WithWeights:(NSArray *)weights;

// These are specialty to problems using the LL scales:
+ (NSNumber *)logScaleValueForDifficulty:(ProblemDifficulty)difficulty;
+ (NSNumber *)logBaseForDifficulty:(ProblemDifficulty)difficulty;

// These are specialty to problems using trig angles:
+ (NSNumber *)angleInDegreesForDifficulty:(ProblemDifficulty)difficulty;
@end
