//
//  CommonExpProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CommonExpProblemGenerator.h"
#import "RandomNumberGenerator.h"

@implementation CommonExpProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    NSNumber *answer = [RandomNumberGenerator decimalWithDifficulty:difficulty];
    
    NSNumber *log = [NSNumber numberWithDouble:(log10([answer doubleValue]))];
    
    NSString *numerator = [NSString stringWithFormat:@"10 ^ %@", [defaultFormatter stringFromNumber:log]];
    
    NSString *helpText = @"Divide the exponent into is integer and fractional parts.  The integer part is the exponent in scientific notation.  Find the fractional part on the L scale, and lookup the corresponding value on the C scale if positive, or CI scale if negative.  This is the radix of the answer in scientific notation.";
    
    Problem *problem = [Problem problem];
    [problem setDelegate:self];
    [problem setDifficulty:difficulty];
    [problem setNumeratorText:numerator];
    [problem setAnswer:answer];
    [problem setHelpText:helpText];
    
    return problem;
}

- (NSNumber *)scaleReadErrorForProblem:(Problem *)problem {
    // The standard difference of the log seems to give the desired output.
    return [super scaleReadErrorForProblem:problem];
}

@end
