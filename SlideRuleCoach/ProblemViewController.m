//
//  ProblemViewController.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProblemViewController.h"
#import "Exam.h"
#import "Problem.h"
#import "NumberFormatterFactory.h"


@implementation ProblemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Init
    }
    return self;
}

@synthesize exam;

- (void)dealloc
{
    [exam release];
    [numeratorBox release];
    [denominatorBox release];
    [dividerLine release];
    [answerInput release];
    [answerBox release];
    [errorBox release];
    [deltaUBox release];
    [avgErrorBox release];
    [avgDeltaUBox release];
    [problemNumberBox release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"viewDidLoad");
    [self populateProblem];
    if( [[exam currentProblem] submittedResult] ){
        NSNumberFormatter *formatter = [NumberFormatterFactory percentageFormatter];
        [answerBox setText:[formatter stringFromNumber:[[exam currentProblem] submittedResult]]];
        [self populateStats];
    }
}

- (void)viewDidUnload
{
    NSLog(@"viewDidUnload");
    //[exam release];
    //exam = nil;
    [numeratorBox release];
    numeratorBox = nil;
    [denominatorBox release];
    denominatorBox = nil;
    [dividerLine release];
    dividerLine = nil;
    [answerInput release];
    answerInput = nil;
    [answerBox release];
    answerBox = nil;
    [errorBox release];
    errorBox = nil;
    [deltaUBox release];
    deltaUBox = nil;
    [avgErrorBox release];
    avgErrorBox = nil;
    [avgDeltaUBox release];
    avgDeltaUBox = nil;
    [problemNumberBox release];
    problemNumberBox = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	NSLog(@"textFieldShouldReturn");
	[textField resignFirstResponder];
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    [self submitAnswer:textField];
    return YES;
}

- (IBAction)submitAnswer:(id)sender {
    NSLog(@"submitAnswer");
    
    [answerInput resignFirstResponder];
    
    NSNumberFormatter *formatter = [NumberFormatterFactory decimalFormatter];
    NSNumber *result = [formatter numberFromString:[answerInput text]];
    
    if(result) {
        [[exam currentProblem] setSubmittedResult:result];
        [answerInput setText:[formatter stringFromNumber:result]]; //Reset it with the interpreted result.
        [answerInput setTextColor:[UIColor blackColor]];
        [self populateStats];
    } else {
        [answerInput setTextColor:[UIColor colorWithRed:0.8 green:0.0 blue:0.0 alpha:1.0]];
    }
}

- (IBAction)gotoNextProblem:(id)sender {
    NSLog(@"gotoNextProblem");
    [exam generateProblem];
    [self populateProblem];
}

- (IBAction)showHelp:(id)sender {
    NSLog(@"showHelp");
}

- (void)populateProblem {    
    // Populate the problem.
    Problem *problem = [exam currentProblem];
    [numeratorBox setText:[problem numeratorText]];
    
    if([problem denominatorText]) {
        [dividerLine setHidden:NO];
        [denominatorBox setText:[problem denominatorText]];
    } else {
        [dividerLine setHidden:YES];
        [denominatorBox setText:nil];
    }
    
    [problemNumberBox setText:[NSString stringWithFormat:@"Problem %u:", [[exam problems] count]]];
    
    // Clear the stats.
    [answerInput setText:nil];
    [answerBox setText:@"----"];
    [errorBox setText:@"----"];
    [deltaUBox setText:@"----"];
    [avgErrorBox setText:@"----"];
    [avgDeltaUBox setText:@"----"];
}

- (void)populateStats {
    Problem *problem = [exam currentProblem];
    
    NSNumberFormatter *formatter = [NumberFormatterFactory decimalFormatterWithSigFigs:4];
    NSNumberFormatter *percentFormatter = [NumberFormatterFactory percentageFormatter];
    NSNumberFormatter *fixnumFormatter = [NumberFormatterFactory fixnumFormatterWithPlaces:3];
    
    [answerBox setText:[formatter stringFromNumber:[problem answer]]];
    [errorBox setText:[percentFormatter stringFromNumber:[problem error]]];
    [avgErrorBox setText:[percentFormatter stringFromNumber:[exam averageError]]];
    [deltaUBox setText:[fixnumFormatter stringFromNumber:[problem scaleReadError]]];
    [avgDeltaUBox setText:[fixnumFormatter stringFromNumber:[exam averageScaleReadError]]];
}

@end
