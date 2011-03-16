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


@implementation ProblemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait)
        || (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (IBAction)submitAnswer:(id)sender {
    NSLog(@"submitAnswer");
    
    NSNumber *result = [NSNumber numberWithDouble:1.1];
    [[exam currentProblem] setSubmittedResult:result];
    
    [self populateStats];
}

- (IBAction)gotoNextProblem:(id)sender {
    NSLog(@"gotoNextProblem");
}

- (void)populateProblem {
    Problem *problem = [exam currentProblem];
    [numeratorBox setText:[problem numeratorText]];
    [denominatorBox setText:[problem denominatorText]];
}

- (void)populateStats {
    //Problem *problem = [exam currentProblem];
}

@end
