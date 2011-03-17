//
//  ProblemViewController.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Exam;

@interface ProblemViewController : UIViewController <UITextFieldDelegate> {
    Exam *exam;
    
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
- (void)populateProblem;
- (void)populateStats;
@end
