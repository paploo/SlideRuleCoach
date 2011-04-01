//
//  ProblemNotesViewController.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/18/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
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
