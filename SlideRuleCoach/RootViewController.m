//
//  RootViewController.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/14/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "RootViewController.h"
#import "ProblemViewController.h"
#import "PreferencesViewController.h"
#import "Proctor.h"
#import "Exam.h"
#import "ProblemDifficulty.h"

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    proctor = [[Proctor alloc] init];
    
    NSDictionary *defaults = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:ProblemDifficultyNormal], @"difficulty", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [proctor sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [proctor examCountInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [proctor sectionLabel:section];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    }

    // Configure the cell.
    Class examClass = [proctor examClassAtIndexPath:indexPath];
    [[cell textLabel] setText:[examClass title]];
    [[cell detailTextLabel] setText:[examClass summary]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    ProblemDifficulty difficulty = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"difficulty"];
    Exam *exam = [proctor startExamAtIndexPath:indexPath withDifficulty:difficulty];
    [exam generateProblem];
    
    ProblemViewController *problemViewController = [[ProblemViewController alloc] initWithNibName:@"ProblemViewController" bundle:nil];
    [problemViewController setExam:exam];
    
    [problemViewController setTitle:[[exam class] title]];
    
    [[self navigationController] pushViewController:problemViewController animated:YES];
    [problemViewController release];
}

- (id)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     This should give details about the exam selected.
     This should push a different view controller.
     */
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [proctor release];
    [super dealloc];
}

#pragma mark - Other Methods

- (UINavigationItem *)navigationItem {
    UINavigationItem *navItem = [super navigationItem];
    UIBarButtonItem *infoButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Preferences" style:UIBarButtonItemStylePlain target:self action:@selector(infoButtonPressed:)];
    [navItem setRightBarButtonItem:infoButtonItem];
    [infoButtonItem release];
    return navItem;
}

- (void)infoButtonPressed:(id)sender {
    PreferencesViewController *preferencesViewController = [[PreferencesViewController alloc] initWithNibName:@"PreferencesViewController" bundle:nil];
    [[self navigationController] pushViewController:preferencesViewController animated:YES];
    [preferencesViewController release];
}

@end
