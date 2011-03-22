//
//  Problem.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/14/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import <Foundation/Foundation.h>
#import "ProblemDifficulty.h"

@protocol ProblemDelegateMethods;

// Problem is responsible for encapsulating
// a problem, it's answer, help text for the problem,
// the submitted result, and the errors.
@interface Problem : NSObject {
    id<ProblemDelegateMethods> delegate;
    NSString *helpText;
    ProblemDifficulty difficulty;
    NSString *numeratorText;
    NSString *denominatorText; //nil when there is no denominator.
    NSNumber *answer;
    NSNumber *submittedResult;
    NSString *userNotes;
}
+ (id)problem;

//Creation properties.  These are writable to aid in problem creation.
@property(nonatomic, assign) id<ProblemDelegateMethods> delegate;
@property ProblemDifficulty difficulty;
@property(nonatomic, retain) NSString *helpText;
@property(nonatomic, retain) NSString *numeratorText;
@property(nonatomic, retain) NSString *denominatorText;
@property(nonatomic, retain) NSNumber *answer;

//Runtime properties.
@property(nonatomic, retain) NSNumber *submittedResult;
@property(nonatomic, retain) NSString *userNotes;

- (NSNumber *)error; //The error in percent of misread.
- (NSNumber *)scaleReadError; //If the scale is 1.0 units long, how far off was I?
@end


@protocol ProblemDelegateMethods <NSObject>

@optional
- (NSNumber *)scaleReadErrorForProblem:(Problem *)problem;

@end