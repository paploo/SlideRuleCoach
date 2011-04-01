//
//  TrigonometricFunctions.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TrigonometricFunctionsExam.h"


@implementation TrigonometricFunctionsExam

+(NSString *)title {
    return @"Trigonometric Functions";
}

+ (NSString *)summary {
    return @"Sine, Cosine and Tangent.";
}

- (id)init {
    if( (self = [super init]) ) {
        NSMutableArray *generators = [NSMutableArray arrayWithCapacity:3];
        [generators addObject:[[[SineProblemGenerator alloc] init] autorelease]];
        [generators addObject:[[[CosineProblemGenerator alloc] init] autorelease]];
        [generators addObject:[[[TangentProblemGenerator alloc] init] autorelease]];
        
        problemGenerator = [[RandomProblemGenerator alloc] initWIthProblemGenerators:generators];
    }
    return self;
}

@end
