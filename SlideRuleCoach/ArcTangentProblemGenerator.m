//
//  ArcTangentProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 4/1/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "ArcTangentProblemGenerator.h"
#import "RandomNumberGenerator.h"
#import "ScaleParameterizer.h"
#import "Trig.h"

@implementation ArcTangentProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    // First we generate an angle we know is in range of the scales.
    NSNumber *randAngle = [RandomNumberGenerator angleInDegreesForDifficulty:difficulty];
    double randAngleInRadians = [randAngle doubleValue] * DEGREE_TO_RADIAN;
    
    // Then we run it through the functions so we know it comes out in computation range.
    double val = tan(randAngleInRadians);
    double angle = atan(val) * RADIAN_TO_DEGREE;
    
    NSNumber *value = [NSNumber numberWithDouble:val];
    NSNumber *angleInRange = [NSNumber numberWithDouble:angle];
    
    // Now do problem setup.
    NSNumber *answer = angleInRange;
    
    NSString *numerator = [NSString stringWithFormat:@"atan(%@)", [defaultFormatter stringFromNumber:value]];
    
    NSString *helpText = @"Find the value on the C scale, and translate to the value on the S scale (if the value is more than 0.1) or ST scale (if it is between 0.01 and 0.1)";
    
    // Build the problem and return.
    Problem *problem = [Problem problem];
    [problem setDelegate:self];
    [problem setDifficulty:difficulty];
    [problem setNumeratorText:numerator];
    [problem setAnswer:answer];
    [problem setHelpText:helpText];
    
    return problem;
}

- (NSNumber *)scaleReadErrorForProblem:(Problem *)problem {
    double uAnswer = [ScaleParameterizer tanScaleParameterForValue:[[problem answer] doubleValue]];
    
    double uSubmitted = [problem submittedResult] ? [ScaleParameterizer tanScaleParameterForValue:[[problem submittedResult] doubleValue]] : 0.0;
    
    return [NSNumber numberWithDouble:(uSubmitted - uAnswer)];
}

@end
