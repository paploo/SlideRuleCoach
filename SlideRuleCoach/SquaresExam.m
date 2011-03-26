//
//  SquaresExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/22/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import "SquaresExam.h"


@implementation SquaresExam

+(NSString *)title {
    return @"Squares";
}

+ (NSString *)summary {
    return @"Squares, sometimes multiplied by a coefficient";
}

- (id)init {
    if( (self = [super init]) ) {
        ProblemGenerator *simpleGen = [[PowersProblemGenerator alloc] initWithPower:[NSNumber numberWithInt:2]];
        ProblemGenerator *GenWithCoeff = [[PowersProblemGenerator alloc] initWithPower:[NSNumber numberWithInt:2] hasCoefficient:YES];
        NSArray *generators = [NSArray arrayWithObjects:simpleGen, GenWithCoeff, nil];
        [simpleGen release];
        [GenWithCoeff release];
        
        problemGenerator = [[RandomProblemGenerator alloc] initWIthProblemGenerators:generators];
    }
    return self;
}

@end
