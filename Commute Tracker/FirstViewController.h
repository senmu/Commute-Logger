//
//  FirstViewController.h
//  Commute Tracker
//
//  Created by Sam Lu on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController {
    UIButton *goingHomeBtn;
    UIButton *goingSchoolBtn;
}

@property(nonatomic,retain) IBOutlet UIButton *goingHomeBtn;
@property(nonatomic,retain) IBOutlet UIButton *goingSchoolBtn;

- (IBAction)letsGoHome:(id)sender;
- (IBAction)letsGoToSchool:(id)sender;

@end
