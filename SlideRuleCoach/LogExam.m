//
//  LogExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/25/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
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
