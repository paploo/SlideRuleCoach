//
//  ProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

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
    return [Problem ProblemWithNumeratorText:@"1.0" denominatorText:@"1.0" answer:[NSNumber numberWithDouble:1.0] helpText:@"N/A" difficulty:difficulty];
}

- (void)dealloc {
    [defaultFormatter release];
    [super dealloc];
}

@end
