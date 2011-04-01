//
//  CommonLogProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/23/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "CommonLogProblemGenerator.h"
#import "RandomNumberGenerator.h"
#import "ScaleParameterizer.h"


@implementation CommonLogProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    NSNumber *functionValue = [RandomNumberGenerator decimalWithDifficulty:difficulty];
    
    NSNumber *answer = [NSNumber numberWithDouble:(log10([functionValue doubleValue]))];
    
    NSString *numerator = [NSString stringWithFormat:@"log10(%@)", [defaultFormatter stringFromNumber:functionValue]];
    
    NSString *helpText = @"Find the integer part of the logarithm by moving the decimal so that the value is between one and ten.   Find the fractional part by transferring from the C scale to the L scale.  (If the original value was less than one, then transfer from teh CI scale to the L scale.)";
    
    Problem *problem = [Problem problem];
    [problem setDelegate:self];
    [problem setDifficulty:difficulty];
    [problem setNumeratorText:numerator];
    [problem setAnswer:answer];
    [problem setHelpText:helpText];
    
    return problem;
}

- (NSNumber *)scaleReadErrorForProblem:(Problem *)problem {
    // This is simply the difference between the two values!
    double uAnswer = [ScaleParameterizer logScaleParameterForValue:[[problem answer] doubleValue]];
    
    double uSubmitted = [problem submittedResult] ? [ScaleParameterizer logScaleParameterForValue:[[problem submittedResult] doubleValue]] : 0.0;
    
    return [NSNumber numberWithDouble:(uSubmitted-uAnswer)];
}

@end
