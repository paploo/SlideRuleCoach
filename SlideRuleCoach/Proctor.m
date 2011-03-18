//
//  Proctor.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Proctor.h"
#import "Exam.h"

@interface Proctor (PrivateMethods)
- (NSArray *)buildExamList;
@end


@implementation Proctor

- (id)init {
    if( (self = [super init]) ){
        examList = [[self buildExamList] retain];
        currentExam = nil;
    }
    return self;
}

@synthesize examList;
@synthesize currentExam;

- (Class)examClassAtIndex:(NSUInteger)index {
    return NSClassFromString([examList objectAtIndex:index]);
}

- (Exam *)startExamAtIndex:(NSUInteger)index {
    return [self startExamAtIndex:index withDifficulty:NORMAL];
}

- (Exam *)startExamAtIndex:(NSUInteger)index withDifficulty:(ProblemDifficulty)difficulty {
    Class examClass = [self examClassAtIndex:index];
    Exam *currExam = [[[examClass alloc] initWithDifficulty:difficulty] autorelease];
    [self setCurrentExam:currExam];
    return currExam; 
}

- (NSArray *)buildExamList {
    return [[[NSArray alloc] initWithObjects:@"Exam", nil] autorelease];
}

- (void)dealloc {
    [examList release];
    [currentExam release];
    [super dealloc];
}

@end
