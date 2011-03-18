//
//  InversionExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InversionExam.h"


@implementation InversionExam

+(NSString *)title {
    return @"Inversion";
}

+ (NSString *)summary {
    return @"Inversion of simple 1/x fractions";
}

- (id)init {
    if( (self = [super init]) ) {
        problemGenerator = [[InversionProblemGenerator alloc] init];
    }
    return self;
}


@end
