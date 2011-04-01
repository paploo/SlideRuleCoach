//
//  PreferencesViewController.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/21/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PreferencesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *difficultyNames;
    NSArray *difficultyValues;
    IBOutlet UITableView *preferenceTableView;
    UIButton *gotoHomePage;
    IBOutlet UILabel *versionLabel;
}
- (IBAction)gotoHomePage:(id)sender;
- (NSString *)versionInfoString;
@end
