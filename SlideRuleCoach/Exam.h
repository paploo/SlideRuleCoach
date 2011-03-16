//
//  Exam.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Problem;
@class ProblemGenerator;

// The base class for all exams.  Each exam selectable
// from the main menu is its own subclass.  Each subclass,
// when selected, is instantiated and creates
// any necessary problem generators needed so that it can
// generate problems, and it keeps track of all the
// problems and can cumulative stats for them.
@interface Exam : NSObject {
    NSString *name;
    NSString *summary;
    NSMutableArray *problems;
    unsigned difficulty;
    ProblemGenerator *problemGenerator;
}
@property(nonatomic, retain, readonly) NSString *name;
@property(nonatomic, retain, readonly) NSString *summary;
@property(nonatomic, retain, readonly) NSMutableArray *problems;
@property unsigned difficulty;
@property(nonatomic, retain, readonly) ProblemGenerator *problemGenerator;
- (Problem *)nextProblem;
- (NSNumber *)averageError;
- (NSNumber *)averageScaleReadError;
@end
