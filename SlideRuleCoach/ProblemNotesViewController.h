//
//  ProblemNotesViewController.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/18/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import <UIKit/UIKit.h>
#import "Exam.h"

@interface ProblemNotesViewController : UIViewController <UITextViewDelegate> {
    Exam *exam;
    
    UIBarButtonItem *notesEditDoneButtonItem;
    
    CGRect numeratorBoxDefaultFrame;
    CGRect defaultNotesFrame;
    
    IBOutlet UILabel *numeratorBox;
    IBOutlet UILabel *denominatorBox;
    IBOutlet UILabel *dividerLine;
    
    IBOutlet UITextView *notesTextView;
}
@property(nonatomic, retain) Exam *exam;
- (IBAction)endNotesEditing:(id)sender;
- (void)setupView;
@end
