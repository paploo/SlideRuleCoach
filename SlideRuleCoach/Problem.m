//
//  Problem.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/14/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import <math.h>

#import "Problem.h"


@implementation Problem

@synthesize delegate;
@synthesize difficulty;
@synthesize helpText;
@synthesize numeratorText;
@synthesize denominatorText;
@synthesize answer;
@synthesize submittedResult;
@synthesize userNotes;

+ (id)problem {
    return [[[self alloc] init] autorelease];
}

- (id)init {
    if( (self = [super init]) ){
        //Let everything init to nil except difficulty, which is a static type.
        [self setDifficulty:ProblemDifficultyNormal];
    }
    return self;
}

- (NSNumber *)error {
    if(submittedResult) {
        double error = ([submittedResult doubleValue] / [answer doubleValue]) - 1.0;
        return [NSNumber numberWithDouble:error];
    } else {
        return nil;
    }
}

- (NSNumber *)scaleReadError {
    if( [delegate respondsToSelector:@selector(scaleReadErrorForProblem:)] ) {
        return [delegate scaleReadErrorForProblem:self];
    } else {
        return nil;
    }
}


-(void)dealloc {
    //[delegate release]; //One doesn't retain or release delegates because they don't own them.
    [helpText release];
    [numeratorText release];
    [denominatorText release];
    [answer release];
    [submittedResult release];
    [userNotes release];
    [super dealloc];
}

@end
