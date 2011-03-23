//
//  SimplePowersProblemGenerator.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/20/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import <Foundation/Foundation.h>
#import "ProblemGenerator.h"

//This is intended only for powers that relate to a scale
//like A, K, sqrt, and cube root.  For exponents and logs,
//use different problem generators.
@interface PowersProblemGenerator : ProblemGenerator {
    NSNumber *power;
    BOOL hasCoefficient;
}
- (id)initWithPower:(NSNumber *)p;
- (id)initWithPower:(NSNumber *)p hasCoefficient:(BOOL)c;
@property(nonatomic, retain) NSNumber *power;
@property BOOL hasCoefficient;
- (NSString *)buildHelpText;
@end
