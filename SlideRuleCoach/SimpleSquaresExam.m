//
//  SquaresExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
        problemGenerator = [[SimpleSquaresProblemGenerator alloc] init];
    }
    return self;
}

@end
