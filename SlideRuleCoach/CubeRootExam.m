//
//  CubeRootExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/22/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "CubeRootExam.h"


@implementation CubeRootExam

+(NSString *)title {
    return @"Cube Roots";
}

+ (NSString *)summary {
    return @"Cube roots, sometimes multiplied by a coefficient";
}

- (id)init {
    if( (self = [super init]) ) {
        double oneThird = 1.0 / 3.0;
        ProblemGenerator *simpleGen = [[PowersProblemGenerator alloc] initWithPower:[NSNumber numberWithDouble:oneThird]];
        ProblemGenerator *genWithCoeff = [[PowersProblemGenerator alloc] initWithPower:[NSNumber numberWithDouble:oneThird] hasCoefficient:YES];
        NSArray *generators = [NSArray arrayWithObjects:simpleGen, genWithCoeff, nil];
        [simpleGen release];
        [genWithCoeff release];
        
        problemGenerator = [[RandomProblemGenerator alloc] initWIthProblemGenerators:generators];
    }
    return self;
}

@end
