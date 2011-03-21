//
//  CompoundFractionsProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CompoundFractionsProblemGenerator.h"
#import "RandomNumberGenerator.h"


@implementation CompoundFractionsProblemGenerator

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    // How many terms?
    NSUInteger numTermCount = [self generateTermCountWithDifficulty:difficulty];
    NSUInteger denTermCount = [self generateTermCountWithDifficulty:difficulty];
    
    // Generate them.
    NSArray *numTerms = [self generateTerms:numTermCount difficulty:difficulty];
    NSArray *denTerms = [self generateTerms:denTermCount difficulty:difficulty];
    
    // Build the string.
    NSString *numerator = [self stringFromTerms:numTerms];
    NSString *denominator = [self stringFromTerms:denTerms];
    
    // Compute the answer.
    double num = [[self productOfTerms:numTerms] doubleValue];
    double den = [[self productOfTerms:denTerms] doubleValue];
    NSNumber *answer = [NSNumber numberWithDouble:(num/den)];
    
    // Get the help text.
    NSString *helpText = @"Slide the first denominator value on C over the first numerator value on D; move the cursor over the next numerator on C.  If no denominators, read answer on D, otherwise slide denominator on C under the cursor.  If no more numerators, read the answer on D under the index on C, otherwise repeat cursor move.";
    
    // Create the problem.
    Problem *problem = [Problem problem];
    [problem setDelegate:self];
    [problem setDifficulty:difficulty];
    [problem setNumeratorText:numerator];
    [problem setDenominatorText:denominator];
    [problem setAnswer:answer];
    [problem setHelpText:helpText];
    
    // Return.
    return problem;
}
                               
- (NSUInteger)generateTermCountWithDifficulty:(ProblemDifficulty)difficulty {
    return [[RandomNumberGenerator integerWithMin:2 max:3] intValue];
}

@end
