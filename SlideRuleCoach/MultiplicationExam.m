//
//  MultiplicationExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MultiplicationExam.h"


@implementation MultiplicationExam

+(NSString *)title {
    return @"Multiplication";
}

+ (NSString *)summary {
    return @"Two to four term multiplication";
}

- (id)init {
    if( (self = [super init]) ) {
        problemGenerator = [[MultiplicationProblemGenerator alloc] init];
    }
    return self;
}

@end
