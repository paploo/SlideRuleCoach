//
//  ProblemNotesViewController.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exam.h"

@interface ProblemNotesViewController : UIViewController <UITextViewDelegate> {
    Exam *exam;
    UIBarButtonItem *notesEditDoneButtonItem;
    
    IBOutlet UILabel *numeratorBox;
    IBOutlet UILabel *denominatorBox;
    IBOutlet UILabel *dividerLine;
    
    IBOutlet UITextView *notesTextView;
    CGRect defaultNotesFrame;
}
@property(nonatomic, retain) Exam *exam;
- (IBAction)endNotesEditing:(id)sender;
- (void)setupView;
@end
