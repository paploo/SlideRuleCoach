//
//  MultiplicationProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MultiplicationProblemGenerator.h"
#import "ProblemDifficulty.h"
#import "Problem.h"
#import "RandomNumberGenerator.h"


@implementation MultiplicationProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    // How many terms?
    NSUInteger termCount = 3;
    
    // Generate them.
    NSMutableArray *terms = [[[NSMutableArray alloc] initWithCapacity:termCount] autorelease];
    for(NSUInteger i=0; i<termCount; i++){
        [terms addObject:[RandomNumberGenerator decimalWithDifficulty:difficulty]];
    }
    
    // Build the string.
    NSMutableArray *termStrings = [[[NSMutableArray alloc] initWithCapacity:termCount] autorelease];
    for(NSNumber *term in terms){
        [defaultFormatter stringFromNumber:term];
    }
    NSString *numerator = [termStrings componentsJoinedByString:@" x "];
    
    // Compute the answer.
    double ans = 1.0;
    for(NSNumber *term in terms){
        ans *= [term doubleValue];
    }
    NSNumber *answer = [NSNumber numberWithDouble:ans];
    
    // Get the help text.
    NSString *helpText = @"Slide the index on the C scale over value on the D scale.  Find the second value on the C scale and read the answer underneath it on the D scale.";
    
    // Create the problem.
    Problem *problem = [[Problem alloc] initWithNumeratorText:numerator denominatorText:nil answer:answer helpText:helpText difficulty:difficulty];
    
    // Return.
    return [problem autorelease];
}

@end
