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
    NSMutableArray *registry = [NSMutableArray array];
    
    NSMutableDictionary *basicArithmeticRegistry = [NSMutableDictionary dictionary];
    [basicArithmeticRegistry setObject:@"BasicArithmetic" forKey:ProctorSectionName];
    NSArray *basicArithmeticExams = [NSArray arrayWithObjects:@"MultiplicationExam", @"InversionExam", @"CompoundFractionsExam", nil];
    [basicArithmeticRegistry setObject:basicArithmeticExams forKey:ProctorSectionExamList];
    [registry addObject:basicArithmeticRegistry];
    
    NSMutableDictionary *basicPowersRegistry = [NSMutableDictionary dictionary];
    [basicPowersRegistry setObject:@"Squares, Cubes and Roots" forKey:ProctorSectionName];
    NSArray *basicPowersExams = [NSArray arrayWithObjects:@"SquaresExam", @"SqrtExam", @"CubesExam", @"CubeRootExam", nil];
    [basicPowersRegistry setObject:basicPowersExams forKey:ProctorSectionExamList];
    [registry addObject:basicPowersRegistry];
    
    NSMutableDictionary *expRegistry = [NSMutableDictionary dictionary];
    [expRegistry setObject:@"Exponents and Logs" forKey:ProctorSectionName];
    NSArray *expExams = [NSArray arrayWithObjects:@"CommonExponentsExam", @"CommonLogExam", @"ExponentsExam", @"LogExam", nil];
    [expRegistry setObject:expExams forKey:ProctorSectionExamList];
    [registry addObject:expRegistry];
    
    NSMutableDictionary *trigRegistry = [NSMutableDictionary dictionary];
    [trigRegistry setObject:@"Trigonometry" forKey:ProctorSectionName];
    NSArray *trigExams = [NSArray arrayWithObjects:@"AngleConversionExam", @"TrigonometricFunctionsExam", nil];
    [trigRegistry setObject:trigExams forKey:ProctorSectionExamList];
    [registry addObject:trigRegistry];
    
    return registry;
}

- (void)dealloc {
    [examRegistry release];
    [currentExam release];
    [super dealloc];
}

@end
