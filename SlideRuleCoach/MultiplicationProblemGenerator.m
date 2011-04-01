//
//  MultiplicationProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/17/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "MultiplicationProblemGenerator.h"
#import "Problem.h"
#import "RandomNumberGenerator.h"


@implementation MultiplicationProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    // How many terms?
    NSUInteger termCount = [self generateTermCountWithDifficulty:difficulty];
    
    // Generate them.
    NSArray *terms = [self generateTerms:termCount difficulty:difficulty];
    
    // Build the string.
    NSString *numerator = [self stringFromTerms:terms];
    
    // Compute the answer.
    NSNumber *answer = [self productOfTerms:terms];
    
    // Get the help text.
    NSString *helpText = @"Slide the index on the C scale over value on the D scale.  Find the second value on the C scale and read the answer underneath it on the D scale.";
    
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

- (NSUInteger)generateTermCountWithDifficulty:(ProblemDifficulty)difficulty {
   return [[RandomNumberGenerator integerWithMin:2 max:4] intValue]; 
}

- (NSArray *)generateTerms:(NSUInteger)termCount difficulty:(ProblemDifficulty)difficulty {
    NSMutableArray *terms = [[NSMutableArray alloc] initWithCapacity:termCount];
    for(NSUInteger i=0; i<termCount; i++){
        [terms addObject:[RandomNumberGenerator decimalWithDifficulty:difficulty]];
    }
    return [terms autorelease];
}

- (NSString *)stringFromTerms:(NSArray *)terms {
    NSMutableArray *termStrings = [[[NSMutableArray alloc] initWithCapacity:[terms count]] autorelease];
    for(NSNumber *term in terms){
        [termStrings addObject:[defaultFormatter stringFromNumber:term]];
    }
    return [termStrings componentsJoinedByString:@" x "];
}

- (NSNumber *)productOfTerms:(NSArray *)terms {
    double ans = 1.0;
    for(NSNumber *term in terms){
        ans *= [term doubleValue];
    }
    return [NSNumber numberWithDouble:ans];
}

@end
