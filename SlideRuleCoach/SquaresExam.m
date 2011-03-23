//
//  SquaresExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
        ProblemGenerator *simpleSquares = [[PowersProblemGenerator alloc] initWithPower:[NSNumber numberWithInt:2]];
        ProblemGenerator *squaresWithCoefs = [[PowersProblemGenerator alloc] initWithPower:[NSNumber numberWithInt:2] hasCoefficient:YES];
        NSArray *generators = [NSArray arrayWithObjects:simpleSquares, squaresWithCoefs, nil];
        [simpleSquares release];
        [squaresWithCoefs release];
        
        problemGenerator = [[RandomProblemGenerator alloc] initWIthProblemGenerators:generators];
    }
    return self;
}

@end
