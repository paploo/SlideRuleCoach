//
//  AngleConversionExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/27/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "AngleConversionExam.h"


@implementation AngleConversionExam

+(NSString *)title {
    return @"Angle Conversion";
}

+ (NSString *)summary {
    return @"Convert to and from radians";
}

- (id)init {
    if( (self = [super init]) ) {
        problemGenerator = [[AngleConversionProblemGenerator alloc] init];
    }
    return self;
}

@end
