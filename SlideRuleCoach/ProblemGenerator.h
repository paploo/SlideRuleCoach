//
//  ProblemGenerator.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Problem;

//ProblemGenerator subclasses produce randomized
//Problems of a given type.
//
//ProblemGenerators may utilize other problem
//generators.  Indeed, a generic RandomProblemGenerator
//can be used to randomly grab problems from an array
//of generators set at initialization.
@interface ProblemGenerator : NSObject {
    NSNumberFormatter *defaultFormatter;
}
@property(nonatomic, retain, readonly) NSNumberFormatter *defaultFormatter;
- (Problem *)nextWithDifficulty:(unsigned)difficulty;
@end
