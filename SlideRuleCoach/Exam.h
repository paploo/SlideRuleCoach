//
//  Exam.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProblemDifficulty.h"
#import "ProblemGenerators.h" // Makes it easier to build subclasses.

@class Problem;
@class ProblemGenerator;

// The base class for all exams.  Each exam selectable
// from the main menu is its own subclass.  Each subclass,
// when selected, is instantiated and creates
// any necessary problem generators needed so that it can
// generate problems, and it keeps track of all the
// problems and can cumulative stats for them.
@interface Exam : NSObject {
    NSMutableArray *problems;
    ProblemDifficulty difficulty;
    ProblemGenerator *problemGenerator;
}
+ (NSString *)title;
+ (NSString *)summary;
// - (id)initWithDifficulty:(ProblemDifficulty)difficulty; // We don't do this so subclasses don't have to define it and call super.
@property(nonatomic, retain, readonly) NSMutableArray *problems;
@property ProblemDifficulty difficulty;
@property(nonatomic, retain, readonly) ProblemGenerator *problemGenerator;
- (Problem *)generateProblem;
- (Problem *)currentProblem;
- (NSNumber *)averageError;
- (NSNumber *)averageScaleReadError;
@end
