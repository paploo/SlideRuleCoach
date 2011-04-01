//
//  MultiplicationProblemGenerator.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/17/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ProblemGenerator.h"

@interface MultiplicationProblemGenerator : ProblemGenerator {
    
}
- (NSUInteger)generateTermCountWithDifficulty:(ProblemDifficulty)difficulty;
- (NSArray *)generateTerms:(NSUInteger)termCount difficulty:(ProblemDifficulty)difficulty;
- (NSString *)stringFromTerms:(NSArray *)terms;
- (NSNumber *)productOfTerms:(NSArray *)terms;
@end