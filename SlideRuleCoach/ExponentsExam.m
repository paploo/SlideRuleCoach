//
//  ExponentsExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/25/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "ExponentsExam.h"


@implementation ExponentsExam

+(NSString *)title {
    return @"Exponents";
}

+ (NSString *)summary {
    return @"Exponents of arbitrary base.";
}

- (id)init {
    if( (self = [super init]) ) {
        problemGenerator = [[ExpProblemGenerator alloc] init];
    }
    return self;
}

@end
