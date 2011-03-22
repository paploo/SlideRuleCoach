//
//  ProblemHelpViewController.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/18/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import "ProblemHelpViewController.h"


@implementation ProblemHelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Problem Help"];
    }
    return self;
}

- (void)dealloc
{   [exam release];
    [helpTextArea release];
    [super dealloc];
}

@synthesize exam;

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
    
    [helpTextArea setText:[[exam currentProblem] helpText]];
}

- (void)viewDidUnload
{
    [helpTextArea release];
    helpTextArea = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
