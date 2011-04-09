//
//  ArcMinuteConversionProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArcMinuteConversionProblemGenerator.h"
#import "ProblemDifficulty.h"
#import "RandomNumberGenerator.h"


@implementation ArcMinuteConversionProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    // Computer the angles in degrees and radians.
    NSNumber *arcMinutes = [RandomNumberGenerator decimalWithMin:0.0 max:60.0];
    NSNumber *decDegrees = [NSNumber numberWithDouble:([arcMinutes doubleValue] / 60.0)];
    
    // Figure out which way to go.
    BOOL toDec = [RandomNumberGenerator bool];

    // Now build the answer and numerator text.
    NSNumber *answer = nil;
    NSString *numerator = nil;
    NSString *helpText = nil;
    if( toDec ) {
        answer = decDegrees;
        numerator = [NSString stringWithFormat:@"%@' in degrees.", [defaultFormatter stringFromNumber:arcMinutes]];
        helpText = @"Divide arc minutes by 60 to get decimal degrees, as per normal division.";
    } else {
        answer = arcMinutes;
        numerator = [NSString stringWithFormat:@"%@° in arc minutes.", [defaultFormatter stringFromNumber:decDegrees]];
        helpText = @"Multiply decmal degrees by 60 to get arc minutes, as per normal multiplication.";
    }

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
