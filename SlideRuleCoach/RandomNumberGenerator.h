//
//  RandomNumberGenerator.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ProblemDifficulty.h"

// For consistency return NSNumber subclasses.
@interface RandomNumberGenerator : NSObject {
    
}
+ (void)randomize;
+ (NSNumber *)integerWithMin:(NSInteger)min max:(NSInteger)max;
+ (NSNumber *)decimal;
+ (NSNumber *)decimalWithMin:(double)min max:(double)max;
+ (NSNumber *)decimalWithMinPower:(NSInteger)min maxPower:(NSInteger)max canBeNegative:(BOOL)canBeNeg;
+ (NSNumber *)decimalWithDifficulty:(ProblemDifficulty)difficulty;
+ (NSNumber *)bool;
+ (NSNumber *)boolWithProbability:(double)prob;
@end
