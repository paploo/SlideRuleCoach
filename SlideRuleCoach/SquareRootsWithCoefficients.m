//
//  SquareRootsWithCoefficients.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SquareRootsWithCoefficients.h"


@implementation SquareRootsWithCoefficients

+(NSString *)title {
    return @"Square Roots";
}

+ (NSString *)summary {
    return @"Square Roots multiplied by a coefficient";
}

- (id)init {
    if( (self = [super init]) ) {
        problemGenerator = [[PowersProblemGenerator alloc] initWithPower:[NSNumber numberWithInt:0.5] hasCoefficient:YES];
    }
    return self;
}


@end
