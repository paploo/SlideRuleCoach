//
//  PreferencesViewController.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/21/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import "PreferencesViewController.h"
#import "ProblemDifficulty.h"


@implementation PreferencesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Preferences"];
        difficultyNames = [[NSArray alloc] initWithObjects:@"Introductory", @"Easy", @"Normal", @"Advanced", @"Master", nil];
        difficultyValues = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:ProblemDifficultyIntroductory], [NSNumber numberWithInteger:ProblemDifficultyEasy], [NSNumber numberWithInteger:ProblemDifficultyNormal], [NSNumber numberWithInteger:ProblemDifficultyAdvanced], [NSNumber numberWithInteger:ProblemDifficultyMaster], nil];
    }
    return self;
}

- (void)dealloc
{
    [difficultyNames release];
    [difficultyValues release];
    [preferenceTableView release];
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
}

- (void)viewDidUnload
{
    [preferenceTableView release];
    preferenceTableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark - Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Difficulty";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell for difficulty.
    if([indexPath indexAtPosition:0] == 0 ) {
        NSUInteger difficultyIndex = [indexPath indexAtPosition: 1];
        [[cell textLabel] setText:[difficultyNames objectAtIndex:difficultyIndex]];
        [[cell detailTextLabel] setText:nil];
        if( [[difficultyValues objectAtIndex:difficultyIndex] intValue] == [[NSUserDefaults standardUserDefaults] integerForKey:@"difficulty"] )
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        else
            [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}

# pragma mark - Table View Delegate Methods

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Save difficulty
    if([indexPath indexAtPosition:0] == 0 ) {
        NSUInteger difficultyIndex = [indexPath indexAtPosition: 1];
        ProblemDifficulty difficulty = [[difficultyValues objectAtIndex:difficultyIndex] intValue];
        [[NSUserDefaults standardUserDefaults] setInteger:difficulty forKey:@"difficulty"];
    }
    
    [preferenceTableView reloadData];
    
    return nil;
}

# pragma mark - Actions

- (IBAction)gotoHomePage:(id)sender {
    NSURL *homepageURL = [NSURL URLWithString:@"http://www.github.com/paploo/SlideRuleCoach"];
    [[UIApplication sharedApplication] openURL:homepageURL];
}

@end
