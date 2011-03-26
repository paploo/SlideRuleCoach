//
//  ExponentsExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/25/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import "ExponentsExam.h"


@implementation ExponentsExam

+(NSString *)title {
    return @"Exponents";
}

+ (NSString *)summary {
    return @"Exponents of arbitrary base.";
}

- (id)init {
    if( (self = [super init]) ) {
        problemGenerator = [[ExpProblemGenerator alloc] init];
    }
    return self;
}

@end
