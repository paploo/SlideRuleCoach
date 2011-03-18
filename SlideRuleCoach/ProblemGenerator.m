//
//  ProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
    //Most problems use a simple log10 scale, so the standard is done here.
    //Note that we have to determine which way around the scale is quickest.
    //Integers show how many revolutions you are off.
    double uAnswer = log10([[problem answer] doubleValue]);
    double uSubmitted = log10([[problem submittedResult] doubleValue]);
    return [NSNumber numberWithDouble:(uSubmitted - uAnswer)];
}

@end
