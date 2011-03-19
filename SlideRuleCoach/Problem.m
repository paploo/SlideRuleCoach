//
//  Problem.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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

+(id)ProblemWithNumeratorText:(NSString *)num denominatorText:(NSString *)den answer:(NSNumber *)ans helpText:(NSString *)help difficulty:(ProblemDifficulty)diff {
    return [[[self alloc] initWithNumeratorText:num denominatorText:den answer:ans helpText:help difficulty:diff] autorelease];
}

-(id)init {
    return [self initWithNumeratorText:@"1.0" denominatorText:@"1.0" answer:[NSNumber numberWithDouble:1.0] helpText:@"N/A" difficulty:ProblemDifficultyNormal];
}

-(id)initWithNumeratorText:(NSString *)num denominatorText:(NSString *)den answer:(NSNumber *)ans helpText:(NSString *)help difficulty:(ProblemDifficulty)diff {
    if( (self = [super init]) ){
        numeratorText = [num retain];
        denominatorText = [den retain];
        answer = [ans retain];
        helpText = [help retain];
        
        submittedResult = nil;
    }
    return self;
}

-(NSNumber *)error {
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
    [helpText release];
    [numeratorText release];
    [denominatorText release];
    [answer release];
    [submittedResult release];
    [userNotes release];
    [super dealloc];
}

@end
