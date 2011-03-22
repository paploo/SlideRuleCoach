//
//  PreferencesViewController.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PreferencesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *difficultyNames;
    NSArray *difficultyValues;
    IBOutlet UITableView *preferenceTableView;
}

@end
