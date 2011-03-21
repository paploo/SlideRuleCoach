//
//  SimplePowersProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PowersProblemGenerator.h"
#import "RandomNumberGenerator.h"

@implementation PowersProblemGenerator

- (id)init {
    return [self initWithPower:[NSNumber numberWithInt:2]];
}

- (id)initWithPower:(NSNumber *)p {
    return [self initWithPower:p coefficient:[NSNumber numberWithInt:1]];
}

- (id)initWithPower:(NSNumber *)p coefficient:(NSNumber *)c {
    if( (self = [super init]) ){
        [self setPower:p];
        [self setCoefficient:c];
    }
    return self;
}

@synthesize power;
@synthesize coefficient;
    
- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    // Generate the base.
    NSNumber *x = [RandomNumberGenerator decimalWithDifficulty:difficulty];
    
    // Build the power text.
    NSString *powerText = nil;
    if( [x doubleValue] >= 1.0 || [x doubleValue] <= -1.0 ) {
        powerText = [defaultFormatter stringFromNumber:x];
    } else {
        NSNumber *xi = [NSNumber numberWithDouble:(1.0/[x doubleValue])];
        NSString *sign = ([x doubleValue]>=0) ? @"" : @"-";
        powerText = [NSString stringWithFormat:@"%@(1/%@)", sign, [defaultFormatter stringFromNumber:xi]];
    }
    
    // Build the numerator text
    NSString *numerator = [NSString stringWithFormat:@"%@ x %@ ^ %@", [defaultFormatter stringFromNumber:coefficient], [defaultFormatter stringFromNumber:x], powerText];
    
    NSString *helpText = @"Find the value on the C scale, read off its appropriate scale.  Some powers on some rules can use the slide to factor in coefficients, such as the A-B scale.";
    
    double ans = [coefficient doubleValue] * pow([x doubleValue], [power doubleValue]);
    NSNumber *answer = [NSNumber numberWithDouble:ans];
    
    
    Problem *problem = [Problem problem];
    [problem setDelegate:self];
    [problem setDifficulty:difficulty];
    [problem setNumeratorText:numerator];
    [problem setAnswer:answer];
    [problem setHelpText:helpText];
    
    return problem;
}

- (NSNumber *)scaleReadErrorForProblem:(Problem *)problem {
    //TODO: This may be incorrect for negative powers.  It depends on how you do it.
    double readError = [[super scaleReadErrorForProblem:problem] doubleValue];
    return [NSNumber numberWithDouble:(readError / [power doubleValue])];
}

- (void)dealloc {
    [power release];
    [coefficient release];
    [super dealloc];
}
    
@end
