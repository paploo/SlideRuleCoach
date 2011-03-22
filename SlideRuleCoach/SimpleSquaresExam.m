//
//  SquaresExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/18/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import "SimpleSquaresExam.h"


@implementation SimpleSquaresExam

+(NSString *)title {
    return @"Simple Squares";
}

+ (NSString *)summary {
    return @"Simple Squaring";
}

- (id)init {
    if( (self = [super init]) ) {
        problemGenerator = [[PowersProblemGenerator alloc] initWithPower:[NSNumber numberWithInt:2]];
    }
    return self;
}

@end
