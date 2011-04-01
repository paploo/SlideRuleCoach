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
        NSMutableArray *generators = [[NSMutableArray alloc] initWithCapacity:3];
        [generators addObject:[[SineProblemGenerator alloc] init]];
        
        problemGenerator = [[RandomProblemGenerator alloc] initWIthProblemGenerators:generators];
        
        [generators release];
    }
    return self;
}

@end
