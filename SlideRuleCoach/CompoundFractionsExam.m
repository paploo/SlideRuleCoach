//
//  CompoundFractionsExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/18/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "CompoundFractionsExam.h"


@implementation CompoundFractionsExam

+(NSString *)title {
    return @"Compound Fractions";
}

+ (NSString *)summary {
    return @"Two to four term multiplication";
}

- (id)init {
    if( (self = [super init]) ) {
        problemGenerator = [[CompoundFractionsProblemGenerator alloc] init];
    }
    return self;
}

@end
