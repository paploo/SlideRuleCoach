//
//  ProblemHelpViewController.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exam.h"

@interface ProblemHelpViewController : UIViewController {
    Exam *exam;
    IBOutlet UITextView *helpTextArea;
}
@property(nonatomic, retain) Exam *exam;
@end
