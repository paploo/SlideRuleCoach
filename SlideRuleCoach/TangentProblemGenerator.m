//
//  TangentProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/31/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "TangentProblemGenerator.h"
#import "RandomNumberGenerator.h"
#import "ScaleParameterizer.h"
#import "Trig.h"

@implementation TangentProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {    
    NSNumber *angle = [RandomNumberGenerator angleInDegreesForDifficulty:difficulty];
    
    double angleInRadians = [angle doubleValue] * DEGREE_TO_RADIAN;
    
    NSNumber *answer = [NSNumber numberWithDouble:tan(angleInRadians)];
    
    NSString *numerator = [NSString stringWithFormat:@"tan(%@°)", [defaultFormatter stringFromNumber:angle]];
    
    NSString *helpText = @"For values under 45 degrees, find the angle on the T scale (or, if smaller than 5.7 degrees, the ST scale), and read off the tangent from the C scale.  For values over 45 degrees, use the CI scale.";
    
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
