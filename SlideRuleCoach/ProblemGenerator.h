//
//  ProblemGenerator.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/15/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import <Foundation/Foundation.h>
#import "ProblemDifficulty.h"
#import "Problem.h"

@class Problem;

//ProblemGenerator subclasses produce randomized
//Problems of a given type.
//
//ProblemGenerators may utilize other problem
//generators.  Indeed, a generic RandomProblemGenerator
//can be used to randomly grab problems from an array
//of generators set at initialization.
@interface ProblemGenerator : NSObject <ProblemDelegateMethods> {
    NSNumberFormatter *defaultFormatter;
}
@property(nonatomic, retain, readonly) NSNumberFormatter *defaultFormatter;
- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty;
@end
