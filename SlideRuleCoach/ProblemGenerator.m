//
//  ProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProblemGenerator.h"
#import "Problem.h"

@implementation ProblemGenerator

- (Problem *)nextWithDifficulty:(unsigned)difficulty {
    return [Problem ProblemWithNumeratorText:@"1.0" denominatorText:@"1.0" answer:[NSNumber numberWithDouble:1.0] helpText:@"N/A"];
}

@end
