//
//  SquaresProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SimpleSquaresProblemGenerator.h"
#import "RandomNumberGenerator.h"


@implementation SimpleSquaresProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    NSNumber *x = [RandomNumberGenerator decimalWithDifficulty:difficulty];
    
    NSString *numerator = [NSString stringWithFormat:@"%@ ^ 2", [defaultFormatter stringFromNumber:x]];
    
    NSString *helpText = @"Find the value on the C scale, read off its square from the A scale.";
    
    NSNumber *answer = [NSNumber numberWithDouble:([x doubleValue]*[x doubleValue])];
    
    Problem *problem = [Problem problem];
    [problem setDelegate:self];
    [problem setDifficulty:difficulty];
    [problem setNumeratorText:numerator];
    [problem setAnswer:answer];
    [problem setHelpText:helpText];
    
    return problem;
}

- (NSNumber *)scaleReadErrorForProblem:(Problem *)problem {
    double readError = [[super scaleReadErrorForProblem:problem] doubleValue];
    return [NSNumber numberWithDouble:(readError / 2.0)];
}

@end