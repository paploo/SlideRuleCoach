//
//  LogExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/25/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import "LogExam.h"


@implementation LogExam

+(NSString *)title {
    return @"Logarithms";
}

+ (NSString *)summary {
    return @"Log with arbitrary base.";
}

- (id)init {
    if( (self = [super init]) ) {
        problemGenerator = [[LogProblemGenerator alloc] init];
    }
    return self;
}

@end
