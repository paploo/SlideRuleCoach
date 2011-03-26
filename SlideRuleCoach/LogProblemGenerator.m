//
//  LogProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LogProblemGenerator.h"
#import "RandomNumberGenerator.h"


@implementation LogProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    // Consider: base ^ power = value, then power = log(value) / log(base)
    
    NSNumber *value = [RandomNumberGenerator logScaleValueForDifficulty:difficulty];
    NSNumber *base = [RandomNumberGenerator logBaseForDifficulty:difficulty];
    NSNumber *power = [NSNumber numberWithDouble:(log([value doubleValue]) / log([base doubleValue]))];
    
    NSNumber *answer = power;
    
    NSString *numerator = [NSString stringWithFormat:@"log_%@( %@ )", [defaultFormatter stringFromNumber:base], [defaultFormatter stringFromNumber:value]];
    
    NSString *helpText = @"Align the index on C with the base on an LL scale.  Find the value on the LL scale and read the power from C.";
    
    Problem *problem = [Problem problem];
    [problem setDelegate:self];
    [problem setDifficulty:difficulty];
    [problem setNumeratorText:numerator];
    [problem setAnswer:answer];
    [problem setHelpText:helpText];
    
    return problem;
}

- (NSNumber *)scaleReadErrorForProblem:(Problem *)problem {
    double uAnswer = log10(log([[problem answer] doubleValue]));
    
    double uSubmitted = 0.0;
    if( [problem submittedResult] )
        uSubmitted = log10(log([[problem submittedResult] doubleValue]));
    
    return [NSNumber numberWithDouble:(uSubmitted - uAnswer)];
}

@end
