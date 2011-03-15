//
//  Problem.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// Problem is responsible for encapsulating
// a problem, it's answer, help text for the problem,
// the submitted result, and the errors.
@interface Problem : NSObject {
    NSString *helpText;
    NSString *numeratorText;
    NSString *denominatorText; //nil when there is no denominator.
    NSNumber *answer;
    NSNumber *submittedResult;
}
+(id)ProblemWithNumeratorText:(NSString *)num denominatorText:(NSString *)den answer:(NSNumber *)ans helpText:(NSString *)help;
-(id)initWithNumeratorText:(NSString *)num denominatorText:(NSString *)den answer:(NSNumber *)ans helpText:(NSString *)help;
@property(nonatomic, retain, readonly) NSString *helpText;
@property(nonatomic, retain, readonly) NSString *numeratorText;
@property(nonatomic, retain, readonly) NSString *denominatorText;
@property(nonatomic, retain, readonly) NSNumber *answer;
@property(nonatomic, retain) NSNumber *submittedResult;
- (NSNumber *)error; //The error in percent of misread.
- (NSNumber *)scaleReadError; //If the scale is 1.0 units long, how far off was I?
@end
