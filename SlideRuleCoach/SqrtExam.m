//
//  SqrtExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SqrtExam.h"


@implementation SqrtExam

+(NSString *)title {
    return @"Square Roots";
}

+ (NSString *)summary {
    return @"Square roots, sometimes multiplied by a coefficient";
}

- (id)init {
    if( (self = [super init]) ) {
        ProblemGenerator *simpleGen = [[PowersProblemGenerator alloc] initWithPower:[NSNumber numberWithDouble:0.5]];
        ProblemGenerator *genWithCoeff = [[PowersProblemGenerator alloc] initWithPower:[NSNumber numberWithDouble:0.5] hasCoefficient:YES];
        NSArray *generators = [NSArray arrayWithObjects:simpleGen, genWithCoeff, nil];
        [simpleGen release];
        [genWithCoeff release];
        
        problemGenerator = [[RandomProblemGenerator alloc] initWIthProblemGenerators:generators];
    }
    return self;
}

@end
