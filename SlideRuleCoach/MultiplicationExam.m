//
//  MultiplicationExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/17/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "MultiplicationExam.h"


@implementation MultiplicationExam

+(NSString *)title {
    return @"Multiplication";
}

+ (NSString *)summary {
    return @"Two to four term multiplication.";
}

- (id)init {
    if( (self = [super init]) ) {
        problemGenerator = [[MultiplicationProblemGenerator alloc] init];
    }
    return self;
}

@end
