//
//  ProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/15/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import <math.h>

#import "ProblemGenerator.h"
#import "Problem.h"
#import "NumberFormatterFactory.h"
#import "ScaleParameterizer.h"

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
    double uAnswer = [ScaleParameterizer mainScaleParameterForValue:[[problem answer] doubleValue]];
    
    double uSubmitted = [problem submittedResult] ? [ScaleParameterizer mainScaleParameterForValue:[[problem submittedResult] doubleValue]] : 0.0;
    
    return [NSNumber numberWithDouble:(uSubmitted - uAnswer)];
}

@end
