//
//  CompoundFractionsExam.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
