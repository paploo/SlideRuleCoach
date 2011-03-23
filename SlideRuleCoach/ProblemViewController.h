//
//  ProblemViewController.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/15/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import <UIKit/UIKit.h>

@class Exam;

@interface ProblemViewController : UIViewController <UITextFieldDelegate> {
    Exam *exam;
    
    CGRect numeratorBoxDefaultFrame;
    
    IBOutlet UILabel *numeratorBox;
    IBOutlet UILabel *denominatorBox;
    IBOutlet UILabel *dividerLine;
    
    IBOutlet UITextField *answerInput;
    
    
    IBOutlet UILabel *answerBox;
    IBOutlet UILabel *errorBox;
    IBOutlet UILabel *deltaUBox;
    IBOutlet UILabel *avgErrorBox;
    IBOutlet UILabel *avgDeltaUBox;
    
    IBOutlet UILabel *problemNumberBox;
}
@property(nonatomic, retain) Exam *exam;
- (IBAction)submitAnswer:(id)sender;
- (IBAction)gotoNextProblem:(id)sender;
- (IBAction)showHelp:(id)sender;
- (IBAction)showNotes:(id)sender;
- (void)populateProblem;
- (void)populateStats;
@end
