//
//  CubesExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CubesExam.h"


@implementation CubesExam

+(NSString *)title {
    return @"Cubes";
}

+ (NSString *)summary {
    return @"Cubes, sometimes multiplied by a coefficient";
}

- (id)init {
    if( (self = [super init]) ) {
        ProblemGenerator *simpleGen = [[PowersProblemGenerator alloc] initWithPower:[NSNumber numberWithInt:3]];
        ProblemGenerator *GenWithCoeff = [[PowersProblemGenerator alloc] initWithPower:[NSNumber numberWithInt:3] hasCoefficient:YES];
        NSArray *generators = [NSArray arrayWithObjects:simpleGen, GenWithCoeff, nil];
        [simpleGen release];
        [GenWithCoeff release];
        
        problemGenerator = [[RandomProblemGenerator alloc] initWIthProblemGenerators:generators];
    }
    return self;
}

@end
