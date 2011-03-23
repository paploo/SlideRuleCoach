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
    return [self initWithPower:p hasCoefficient:NO];
}

- (id)initWithPower:(NSNumber *)p coefficient:(BOOL)c {
    if( (self = [super init]) ){
        [self setPower:p];
        [self setHasCoefficient:c];
    }
    return self;
}

@synthesize power;
@synthesize hasCoefficient;
    
- (Problem *)nextWithDifficulty:(ProblemDifficulty)difficulty {
    // Generate the base.
    NSNumber *x = [RandomNumberGenerator decimalWithDifficulty:difficulty];
    
    // Generate the coeff.
    NSNumber *coefficient = nil;
    if(hasCoefficient)
        coefficient = [RandomNumberGenerator decimalWithDifficulty:difficulty];
    else
        coefficient = [NSNumber numberWithDouble:1.0];
    
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
    if( hasCoefficient )
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
    
    if(magnifiedPower == cube)
        return @"Find the value on the D scale, and read its cube off of the K scale.  If there is a coefficient, record the answer and multiply normally.\n\nAlternative Method:\nIf you have a cube-root scale, then find the value on the cube-root scale and read off the answer from the D scale.  If there is a coefficient, slide the index of the C scale over the cube found on the D scale, and multiply normally.";
    else if(magnifiedPower == square)
        return @"Find the value on the C scale, and read the square off of the B scale.  If there is a coefficient, slide the index of C over the base value on D, then read the answer on A over the coefficient on B.\n\nAlternative Method:\nIf you have a square-root scale, then find the value on the square-root scale and read off the answer from the D scale.  If there is a coefficient, slide the index of the C scale over the square found on the D scale and multiply normally.";
    else if(magnifiedPower == sqrt)
        return @"Find the value on the A scale, and read off the square root on the D scale.  If there is a coefficient, slide the index of C over the found root on D, and multiply normally.\n\nAlternative Method:\nIf you hae a square root scale, then find the value on the D scale and read off the answer from the root scale.  If there is a coefficient, write down the value of the root and multiply normaly.";
    else if(magnifiedPower == cbroot)
        return @"Find the value on the K scale and read off the cube root on the D scale.  If there is a coefficient, slide the index of C over the root found on D, and multiply normally.\n\nAlternative Method:\nIf you have a cube root scale, then find the value on the D scale and read off the answer from the root scale.  If there is a coefficeint, write down the value of the root and multiply normally.";
    else
        return @"Find the value on the C scale, read off its appropriate scale.  Some powers on some rules can use the slide to factor in coefficients, such as the A-B scale.";
}

- (void)dealloc {
    [power release];
    [super dealloc];
}
    
@end
