//
//  Proctor.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Exam;

//Proctor's job is to manage the list of available
//exams, and to instantiate a new exam when necessary.
@interface Proctor : NSObject {
    NSArray *examList;
    Exam *currentExam;
}
@property(nonatomic, retain) NSArray *examList;
@property(nonatomic, retain) Exam *currentExam;
- (Class)examClassAtIndex:(NSUInteger)index;
- (Exam *)startExamAtIndex:(NSUInteger)index;
@end
