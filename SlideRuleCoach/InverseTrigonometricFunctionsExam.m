//
//  InverseTrigonometricFunctionsExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 4/1/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "InverseTrigonometricFunctionsExam.h"


@implementation InverseTrigonometricFunctionsExam

+(NSString *)title {
    return @"Inverse Trig Functions";
}

+ (NSString *)summary {
    return @"Arc Sine, Ar Cosine and Arc Tangent.";
}

- (id)init {
    if( (self = [super init]) ) {
        NSMutableArray *generators = [NSMutableArray arrayWithCapacity:3];
        [generators addObject:[[[ArcSineProblemGenerator alloc] init] autorelease]];
        [generators addObject:[[[ArcCosineProblemGenerator alloc] init] autorelease]];
        [generators addObject:[[[ArcTangentProblemGenerator alloc] init] autorelease]];
        
        problemGenerator = [[RandomProblemGenerator alloc] initWIthProblemGenerators:generators];
    }
    return self;
}

@end
