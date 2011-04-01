//
//  SineProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/28/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "SineProblemGenerator.h"
#import "RandomNumberGenerator.h"
#import "ScaleParameterizer.h"
#import "Trig.h"

@implementation SineProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {    
    NSNumber *angle = [RandomNumberGenerator angleInDegreesForDifficulty:difficulty];
    
    double angleInRadians = [angle doubleValue] * DEGREE_TO_RADIAN;
    
    NSNumber *answer = [NSNumber numberWithDouble:sin(angleInRadians)];
    
    NSString *numerator = [NSString stringWithFormat:@"sin(%@°)", [defaultFormatter stringFromNumber:angle]];
    
    NSString *helpText = @"Find the angle on the S scale (or ST scale if smaller than 5.7 degress), and read the value off of the C scale.";
    
    Problem *problem = [Problem problem];
    [problem setDelegate:self];
    [problem setDifficulty:difficulty];
    [problem setNumeratorText:numerator];
    [problem setAnswer:answer];
    [problem setHelpText:helpText];
    
    return problem;
}

- (NSNumber *)scaleReadErrorForProblem:(Problem *)problem {
    double uAnswer = [ScaleParameterizer mainScaleParameterForValue:[[problem answer] doubleValue]];
    
    double uSubmitted = [problem submittedResult] ? [ScaleParameterizer mainScaleParameterForValue:[[problem submittedResult] doubleValue]] : 0.0;
    
    return [NSNumber numberWithDouble:(uSubmitted - uAnswer)];
}

@end
