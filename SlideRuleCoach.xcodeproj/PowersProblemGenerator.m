//
//  SimplePowersProblemGenerator.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/20/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
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
    if( [power doubleValue] >= 1.0 || [power doubleValue] <= -1.0 ) {
        powerText = [defaultFormatter stringFromNumber:power];
    } else {
        NSNumber *pi = [NSNumber numberWithDouble:(1.0/[power doubleValue])];
        NSString *sign = ([power doubleValue]>=0) ? @"" : @"-";
        powerText = [NSString stringWithFormat:@"%@(1/%@)", sign, [defaultFormatter stringFromNumber:pi]];
    }
    
    // Build the numerator text
    NSString *numerator = nil;
    if( [coefficient doubleValue] == 1.0 )
        numerator = [NSString stringWithFormat:@"%@ ^ %@", [defaultFormatter stringFromNumber:x], powerText];
    else
        numerator = [NSString stringWithFormat:@"%@ x %@ ^ %@", [defaultFormatter stringFromNumber:coefficient], [defaultFormatter stringFromNumber:x], powerText];
    
    NSString *helpText = [self buildHelpText];
    
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

- (NSString *)buildHelpText {    
    //To deal with rounding errors, we first multiply the double value by 1E6 and convert to int.
    int magnifier = 1000000;
    int magnifiedPower = (int)((double)magnifier * [power doubleValue]);
    int cube = magnifier * 3;
    int square = magnifier * 2;
    int sqrt = (int)(magnifier * 0.5);
    int cbroot = (int)(magnifier * (1.0/3.0));
    
#warning Help text not completed.
    if(magnifiedPower == cube)
        return @"TODO: Cube Help";
    else if(magnifiedPower == square)
        return @"TODO: Square Help";
    else if(magnifiedPower == sqrt)
        return @"TODO: Sqrt Help";
    else if(magnifiedPower == cbroot)
        return @"TODO: Cube Root Help";
    else
        return @"Find the value on the C scale, read off its appropriate scale.  Some powers on some rules can use the slide to factor in coefficients, such as the A-B scale.";
}

- (void)dealloc {
    [power release];
    [coefficient release];
    [super dealloc];
}
    
@end
