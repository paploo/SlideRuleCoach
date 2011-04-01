//
//  CommonLogExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/23/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "CommonLogExam.h"


@implementation CommonLogExam

+(NSString *)title {
    return @"Common Logs";
}

+ (NSString *)summary {
    return @"Log base ten.";
}

- (id)init {
    if( (self = [super init]) ) {
        problemGenerator = [[CommonLogProblemGenerator alloc] init];
    }
    return self;
}

@end
