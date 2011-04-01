//
//  ProblemNotesViewController.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/18/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "ProblemNotesViewController.h"


@implementation ProblemNotesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Problem Notes"];
        notesEditDoneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(endNotesEditing:)];
        //notesEditDoneButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(endNotesEditing:)];
    }
    return self;
}

- (void)dealloc
{
    [exam release];
    [notesEditDoneButtonItem release];
    [numeratorBox release];
    [denominatorBox release];
    [dividerLine release];
    [notesTextView release];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    numeratorBoxDefaultFrame = [numeratorBox frame];
    defaultNotesFrame = [notesTextView frame];
    
    [self setupView];
}

- (void)viewDidUnload
{
    [numeratorBox release];
    numeratorBox = nil;
    [denominatorBox release];
    denominatorBox = nil;
    [dividerLine release];
    dividerLine = nil;
    [notesTextView release];
    notesTextView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/* Uncomment if you want to override the NavigationItem when pushed instead of just when the keyboard shows.
- (UINavigationItem *)navigationItem {
    UINavigationItem *navItem = [super navigationItem];
    [navItem setRightBarButtonItem:notesEditDoneButtonItem];
    return navItem;
}
*/

#pragma mark - TextView Delegate Methods

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
    if(textView == notesTextView)
        [self endNotesEditing:textView];
    return YES;
}

- (void)keyboardWasShown:(NSNotification *)aNote {
    [[self navigationItem] setRightBarButtonItem:notesEditDoneButtonItem animated:YES];
    
    //Now we need to resize the text field and scroll to the selected text.
    CGSize kbSize = [[[aNote userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect newFrame = CGRectMake(defaultNotesFrame.origin.x, defaultNotesFrame.origin.y, defaultNotesFrame.size.width, defaultNotesFrame.size.height-kbSize.height);
    [notesTextView setFrame:newFrame];
    
    NSRange selectionRange = [notesTextView selectedRange];
    [notesTextView scrollRangeToVisible:selectionRange];
}

- (void)keyboardWillBeHidden:(NSNotification *)aNote {
    [[self navigationItem] setRightBarButtonItem:nil animated:YES];
    
    //Now we need to size back to the default
    [notesTextView setFrame:defaultNotesFrame];
}

#pragma mark - Actions

- (IBAction)endNotesEditing:(id)sender {
    if([notesTextView isFirstResponder])
        [notesTextView resignFirstResponder];
    Problem *problem = [exam currentProblem];
    [problem setUserNotes:[notesTextView text]];
}

#pragma mark - Misc

- (void)setupView {
    Problem *problem = [exam currentProblem];
    [notesTextView setText:[problem userNotes]];
    
    [numeratorBox setText:[problem numeratorText]];
    
    if([problem denominatorText]) {
        [dividerLine setHidden:NO];
        [denominatorBox setText:[problem denominatorText]];
        [numeratorBox setFrame:numeratorBoxDefaultFrame];
    } else {
        [dividerLine setHidden:YES];
        [denominatorBox setText:nil];
        CGRect shiftedFrame = CGRectOffset(numeratorBoxDefaultFrame, 0.0, 11.0);
        [numeratorBox setFrame:shiftedFrame];
    }
}

@end
