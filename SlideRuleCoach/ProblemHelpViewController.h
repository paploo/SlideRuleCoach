//
//  ProblemHelpViewController.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/18/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exam.h"

@interface ProblemHelpViewController : UIViewController {
    Exam *exam;
    IBOutlet UITextView *helpTextArea;
}
@property(nonatomic, retain) Exam *exam;
@end
