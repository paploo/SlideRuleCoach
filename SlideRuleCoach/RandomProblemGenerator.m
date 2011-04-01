//
//  RandomProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/22/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "RandomProblemGenerator.h"
#import "RandomNumberGenerator.h"


@implementation RandomProblemGenerator

- (id)init {
    return [self initWIthProblemGenerators:nil];
}

- (id)initWIthProblemGenerators:(NSArray *)generators {
    return [self initWIthProblemGenerators:generators weights:nil]; 
}

- (id)initWIthProblemGenerators:(NSArray *)generators weights:w {
    if( (self == [super init]) ){
        problemGenerators = [generators retain];
        weights = [w retain];
    }
    return self;
}

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    ProblemGenerator *randomGenerator = nil;
    if( weights )
        randomGenerator = [RandomNumberGenerator randomElementFromArray:problemGenerators WithWeights:weights];
    else
        randomGenerator = [RandomNumberGenerator randomElementFromArray:problemGenerators];
    
    Problem *problem = [randomGenerator nextWithDifficulty:difficulty];
    
    return problem;
}

- (void)dealloc {
    [problemGenerators release];
    [weights release];
    [super dealloc];
}

@end
