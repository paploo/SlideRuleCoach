//
//  ProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/15/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import <math.h>

#import "ProblemGenerator.h"
#import "Problem.h"
#import "NumberFormatterFactory.h"

@implementation ProblemGenerator

- (id)init {
    if( (self = [super init]) ){
        defaultFormatter = [[NumberFormatterFactory decimalFormatterWithSigFigs:4] retain];
    }
    return self;
}

@synthesize defaultFormatter;

- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    return nil;
}

- (void)dealloc {
    [defaultFormatter release];
    [super dealloc];
}

- (NSNumber *)scaleReadErrorForProblem:(Problem *)problem {
    //Most problems use a simple log10 scale or can derive their answer from it,
    //so this common routine is done here.
    double uAnswer = log10([[problem answer] doubleValue]);
    
    double uSubmitted = [problem submittedResult] ? log10([[problem submittedResult] doubleValue]) : 0.0;
    
    return [NSNumber numberWithDouble:(uSubmitted - uAnswer)];
}

@end
