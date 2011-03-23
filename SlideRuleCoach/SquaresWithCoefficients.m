//
//  SquaresWithCoefficients.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SquaresWithCoefficients.h"

@implementation SquaresWithCoefficients

+(NSString *)title {
    return @"Squares With Coefficients";
}

+ (NSString *)summary {
    return @"Squares multiplied by a coefficient";
}

- (id)init {
    if( (self = [super init]) ) {
        problemGenerator = [[PowersProblemGenerator alloc] initWithPower:[NSNumber numberWithInt:2] hasCoefficient:YES];
    }
    return self;
}

@end
