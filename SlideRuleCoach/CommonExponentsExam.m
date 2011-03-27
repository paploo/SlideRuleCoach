//
//  CommonExponentsExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/22/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import "CommonExponentsExam.h"


@implementation CommonExponentsExam

+(NSString *)title {
    return @"Common Exponent";
}

+ (NSString *)summary {
    return @"Ten to the power of another number.";
}

- (id)init {
    if( (self = [super init]) ) {
        problemGenerator = [[CommonExpProblemGenerator alloc] init];
    }
    return self;
}

@end