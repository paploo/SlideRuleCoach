//
//  Problem.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Problem.h"


@implementation Problem

@synthesize helpText;
@synthesize numeratorText;
@synthesize denominatorText;
@synthesize answer;
@synthesize submittedResult;

+(id)ProblemWithNumeratorText:(NSString *)num denominatorText:(NSString *)den answer:(NSNumber *)ans helpText:(NSString *)help {
    return [[[self alloc] initWithNumeratorText:num denominatorText:den answer:ans helpText:help] autorelease];
}

-(id)init {
    return [self initWithNumeratorText:@"1.0" denominatorText:@"1.0" answer:[NSNumber numberWithDouble:1.0] helpText:@"N/A"];
}

-(id)initWithNumeratorText:(NSString *)num denominatorText:(NSString *)den answer:(NSNumber *)ans helpText:(NSString *)help
{
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
        NSLog(@"submittedResult == nil");
        return nil;
    }
}

- (NSNumber *)scaleReadError {
    //Most problems use a simple log10 scale, so the standard is done here.
    //Note that we have to determine which way around the scale is quickest.
    //Also note that this is always positive.
    //Question: Would it be better to return the whole difference including
    //number of "revolutions" off?
    return nil;
}


-(void)dealloc {
    [helpText release];
    [numeratorText release];
    [denominatorText release];
    [answer release];
    [submittedResult release];
    [super dealloc];
}

@end
