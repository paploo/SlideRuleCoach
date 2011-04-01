//
//  Proctor.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/15/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProblemDifficulty.h"

@class Exam;

//Proctor's job is to manage the list of available
//exams, and to instantiate a new exam when necessary.
@interface Proctor : NSObject {
    NSArray *examRegistry;
    Exam *currentExam;
}
@property(nonatomic, retain) NSArray *examRegistry;
@property(nonatomic, retain) Exam *currentExam;
- (NSString *)sectionLabel:(NSInteger)section;
- (NSUInteger)sectionCount;
- (NSUInteger)examCountInSection:(NSInteger)section;
- (Class)examClassAtIndexPath:(NSIndexPath *)indexPath;
- (Exam *)startExamAtIndexPath:(NSIndexPath *)indexPath;
- (Exam *)startExamAtIndexPath:(NSIndexPath *)indexPath withDifficulty:(ProblemDifficulty)difficulty;
@end