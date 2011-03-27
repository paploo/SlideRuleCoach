//
//  ExpProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/25/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import "ExpProblemGenerator.h"
#import "RandomNumberGenerator.h"
#import "ScaleParameterizer.h"

@implementation ExpProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    // Consider: base ^ power = value, then power = log(value) / log(base)
    
    NSNumber *value = [RandomNumberGenerator logScaleValueForDifficulty:difficulty];
    NSNumber *base = [RandomNumberGenerator logBaseForDifficulty:difficulty];
    NSNumber *power = [NSNumber numberWithDouble:(log([value doubleValue]) / log([base doubleValue]))];
    NSLog(@"%f ^ %f = %f", [base doubleValue], [power doubleValue], [value doubleValue]);
    
    NSNumber *answer = value;
    
    NSString *numerator = [NSString stringWithFormat:@"%@ ^ %@", [defaultFormatter stringFromNumber:base], [defaultFormatter stringFromNumber:power]];
    
    NSString *helpText = @"Align the index on C with the base on an LL scale.  Find the exponent on C and read the answer aligned with it on the appropriate LL scale.";
    
    Problem *problem = [Problem problem];
    [problem setDelegate:self];
    [problem setDifficulty:difficulty];
    [problem setNumeratorText:numerator];
    [problem setAnswer:answer];
    [problem setHelpText:helpText];
    
    return problem;
}

- (NSNumber *)scaleReadErrorForProblem:(Problem *)problem {
    double uAnswer = [ScaleParameterizer logLogScaleParameterForValue:[[problem answer] doubleValue]];
    
    double uSubmitted = [problem submittedResult] ? [ScaleParameterizer logLogScaleParameterForValue:[[problem submittedResult] doubleValue]] : 0.0;
    
    return [NSNumber numberWithDouble:(uSubmitted - uAnswer)];
}

@end