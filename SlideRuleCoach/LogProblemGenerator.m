//
//  LogProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/25/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import "LogProblemGenerator.h"
#import "RandomNumberGenerator.h"
#import "ScaleParameterizer.h"


@implementation LogProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    // Consider: base ^ power = value, then power = log(value) / log(base)
    
    NSNumber *value = [RandomNumberGenerator logScaleValueForDifficulty:difficulty];
    NSNumber *base = [RandomNumberGenerator logBaseForDifficulty:difficulty];
    NSNumber *power = [NSNumber numberWithDouble:(log([value doubleValue]) / log([base doubleValue]))];
    NSLog(@"%f ^ %f = %f", [base doubleValue], [power doubleValue], [value doubleValue]);
    
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
    double uAnswer = [ScaleParameterizer logLogScaleParameterForValue:[[problem answer] doubleValue]];
    
    double uSubmitted = [problem submittedResult] ? [ScaleParameterizer logLogScaleParameterForValue:[[problem submittedResult] doubleValue]] : 0.0;
    
    return [NSNumber numberWithDouble:(uSubmitted - uAnswer)];
}

@end
