//
//  CosineProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CosineProblemGenerator.h"
#import "RandomNumberGenerator.h"
#import "ScaleParameterizer.h"
#import "Trig.h"


@implementation CosineProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {    
    NSNumber *angle = [RandomNumberGenerator angleInDegreesForDifficulty:difficulty];
    
    double angleInRadians = [angle doubleValue] * DEGREE_TO_RADIAN;
    
    NSNumber *answer = [NSNumber numberWithDouble:cos(angleInRadians)];
    
    NSString *numerator = [NSString stringWithFormat:@"cos(%@°)", [defaultFormatter stringFromNumber:angle]];
    
    NSString *helpText = @"Find the angle on the reverse numbering on the S scale (or ST scale if smaller than 5.7 degress), and read the value off of the C scale.  If there is no reverse numbering, transform to sin(x) by subtracting the angle from 90 degrees";
    
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
