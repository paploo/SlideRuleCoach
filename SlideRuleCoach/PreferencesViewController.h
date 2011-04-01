//
//  PreferencesViewController.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/21/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
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
