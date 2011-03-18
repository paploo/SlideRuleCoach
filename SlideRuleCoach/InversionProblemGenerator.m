//
//  InversionProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InversionProblemGenerator.h"
#import "Problem.h"
#import "RandomNumberGenerator.h"

@implementation InversionProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    NSNumber *x = [RandomNumberGenerator decimalWithDifficulty:difficulty];
    
    NSString *numerator = @"1";
    NSString *denominator = [defaultFormatter stringFromNumber:x];
    
    NSNumber *answer = [NSNumber numberWithDouble:(1.0 / [x doubleValue])];
    
    NSString *helpText = @"Slide the cursor over the denominator on C and read off the inverse on CI.";
    
    Problem *problem = [[Problem alloc] initWithNumeratorText:numerator denominatorText:denominator answer:answer helpText:helpText difficulty:difficulty];
    [problem setDelegate:self];
    return [problem autorelease];
}

- (NSNumber *)scaleReadErrorForProblem:(Problem *)problem {
    //Since CI goes backwards, we need to take the negative.
    double readError = [[super scaleReadErrorForProblem:problem] doubleValue];
    return [NSNumber numberWithDouble:(-readError)];
}

@end
