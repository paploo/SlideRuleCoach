//
//  AngleConversionProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/27/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "AngleConversionProblemGenerator.h"
#import "RandomNumberGenerator.h"
#import "ScaleParameterizer.h"
#import "Trig.h"

@implementation AngleConversionProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    // Computer the angles in degrees and radians.
    NSNumber *degrees = [RandomNumberGenerator angleInDegreesForDifficulty:difficulty];
    NSNumber *radians = [NSNumber numberWithDouble:([degrees doubleValue] * DEGREE_TO_RADIAN)];
    
    // Choose which way to convert.
    BOOL isDegreesToRadians = [RandomNumberGenerator bool];
    
    // Now build the answer and numerator text.
    NSNumber *answer = nil;
    NSString *numerator = nil;
    if( isDegreesToRadians ) {
        answer = radians;
        numerator = [NSString stringWithFormat:@"%@° in radians.", [defaultFormatter stringFromNumber:degrees]];
    } else {
        answer = degrees;
        numerator = [NSString stringWithFormat:@"%@ rads in degrees.", [defaultFormatter stringFromNumber:radians]];
    }
    
    // Get the help text.
    NSString *helpText = @"First find the 'r' mark on the D scale.  (If you have no 'r' mark, then find it's location by putting pi on the C scale over 180 on the D scale, and read the location of 'r' on D under the index on C.)  Read an angle in degrees on the D scale, and it's conversion to/from radians on the C scale.  Note that the ratio is about 60 degrees to the radian for estimating the location of the decimal point.";
    
    // Create the problem.
    Problem *problem = [Problem problem];
    [problem setDelegate:self];
    [problem setDifficulty:difficulty];
    [problem setNumeratorText:numerator];
    [problem setAnswer:answer];
    [problem setHelpText:helpText];
    
    // Return.
    return problem;
}

@end
