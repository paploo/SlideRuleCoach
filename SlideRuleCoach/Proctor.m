//
//  Proctor.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/15/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import "Proctor.h"
#import "Exam.h"
#import "Exams.h"
#import "RandomNumberGenerator.h"

@interface Proctor (PrivateMethods)
- (NSArray *)buildExamRegistry;
@end

static NSString *ProctorSectionName = @"SectionName";
static NSString *ProctorSectionExamList = @"SectionExamList";
static NSInteger ProctorSectionIndexPosition = 0;
static NSInteger ProctorSectionExamIndexPosition = 1;

@implementation Proctor

- (id)init {
    if( (self = [super init]) ){
        [RandomNumberGenerator randomize]; //This is a good time to do this.
        examRegistry = [[self buildExamRegistry] retain];
        currentExam = nil;
    }
    return self;
}

@synthesize examRegistry;
@synthesize currentExam;

- (NSUInteger)sectionCount {
    return [examRegistry count];
}

- (NSString *)sectionLabel:(NSInteger)section {
    NSDictionary *sectionInfo = [examRegistry objectAtIndex:section];
    return [sectionInfo valueForKey:ProctorSectionName];
}

- (NSUInteger)examCountInSection:(NSInteger)section {
    NSDictionary *sectionInfo = [examRegistry objectAtIndex:section];
    return [[sectionInfo valueForKey:ProctorSectionExamList] count];
}

- (Class)examClassAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *sectionInfo = [examRegistry objectAtIndex:[indexPath indexAtPosition:ProctorSectionIndexPosition]];
    NSArray *examList = [sectionInfo valueForKey:ProctorSectionExamList];
    NSString *className = [examList objectAtIndex:[indexPath indexAtPosition:ProctorSectionExamIndexPosition]];
    return NSClassFromString(className);
}

- (Exam *)startExamAtIndexPath:(NSIndexPath *)indexPath {
    return [self startExamAtIndexPath:indexPath withDifficulty:ProblemDifficultyNormal];
}

- (Exam *)startExamAtIndexPath:(NSIndexPath *)indexPath withDifficulty:(ProblemDifficulty)difficulty {
    Class examClass = [self examClassAtIndexPath:indexPath];
    Exam *exam = [[examClass alloc] init];
    [exam setDifficulty:difficulty];
    [self setCurrentExam:exam];
    return [exam autorelease];
}

// [{ProctorSectionName:@"Basic", ProctorExamList:[@"MultiplicationExam"]}]
- (NSArray *)buildExamRegistry {
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:
             @"Basic Arithmetic", ProctorSectionName,
             [NSArray arrayWithObjects:@"MultiplicationExam", @"InversionExam", @"CompoundFractionsExam", nil], ProctorSectionExamList,
             nil],
            [NSDictionary dictionaryWithObjectsAndKeys:
             @"Squares, Cubes and Roots", ProctorSectionName,
             [NSArray arrayWithObjects:@"SimpleSquaresExam", nil], ProctorSectionExamList,
             nil],
            nil];
}

- (void)dealloc {
    [examRegistry release];
    [currentExam release];
    [super dealloc];
}

@end
