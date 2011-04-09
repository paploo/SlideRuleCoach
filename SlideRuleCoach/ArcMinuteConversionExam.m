//
//  ArcMinuteConversionExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 4/8/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "ArcMinuteConversionExam.h"


@implementation ArcMinuteConversionExam

+(NSString *)title {
    return @"Arc Minute Conversion";
}

+ (NSString *)summary {
    return @"Convert to and from arc minutes.";
}

- (id)init {
    if( (self = [super init]) ) {
        problemGenerator = [[ArcMinuteConversionProblemGenerator alloc] init];
    }
    return self;
}

@end
