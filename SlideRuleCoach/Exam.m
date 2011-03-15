//
//  Exam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Exam.h"
#import "Problem.h"


@implementation Exam

- (id)init {
    if( (self = [super init]) ) {
        name = @"Abstract Exam";
        summary = @"An abstract exam that returns no problems.";
        problems = [[NSMutableArray alloc] initWithCapacity:20];
    }
    return self;
}

@synthesize name;
@synthesize summary;
@synthesize problems;
@synthesize difficulty;

- (Problem *)nextProblem {
    return nil;
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
    [name release];
    [summary release];
    [problems release];
    [super dealloc];
}

@end
