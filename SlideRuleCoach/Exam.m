//
//  Exam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Exam.h"
#import "Problem.h"
#import "ProblemGenerator.h"


@implementation Exam

+ (NSString *)name {
    return @"Abstract Exam";
}

+ (NSString *)summary {
    return @"An abstract exam that returns no problems.";
}

- (id)init {
    if( (self = [super init]) ) {
        problemGenerator = [[ProblemGenerator alloc] init];
        problems = [[NSMutableArray alloc] initWithCapacity:20];
    }
    return self;
}

@synthesize problems;
@synthesize difficulty;
@synthesize problemGenerator;

- (Problem *)nextProblem {
    Problem *problem = [problemGenerator nextWithDifficulty:[self difficulty]];
    [[self problems] addObject:problem];
    return problem;
}

- (Problem *)currentProblem {
    return [[self problems] lastObject];
}

- (NSNumber *)averageError {
    double sum = 0.0;
    for(Problem * problem in problems){
        sum += abs([[problem error] doubleValue]);
    }
    return [NSNumber numberWithDouble:(sum/[problems count])];
}

- (NSNumber *)averageScaleReadError {
    double sum = 0.0;
    for(Problem * problem in problems){
        sum += abs([[problem scaleReadError] doubleValue]);
    }
    return [NSNumber numberWithDouble:(sum/[problems count])];
}

- (void)dealloc {
    [problems release];
    [problemGenerator release];
    [super dealloc];
}

@end
