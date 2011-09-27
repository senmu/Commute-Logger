//
//  CommuteHomeViewController.h
//  Commute Tracker
//
//  Created by Sam Lu on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CommuteHomeViewController : UIViewController {
    UIButton *startCommuteBtn;
    UIButton *transferAt8thStBtn;
    UIButton *mcknightBtn;
    UIButton *transferAtMarlboroughBtn;
    UIButton *abbeydaleBtn;
    UIButton *endCommuteBtn;
    
    NSDate *lastRecordedTime;
}

@property(nonatomic,retain) IBOutlet UIButton *startCommuteBtn;
@property(nonatomic,retain) IBOutlet UIButton *transferAt8thStBtn;
@property(nonatomic,retain) IBOutlet UIButton *mcknightBtn;
@property(nonatomic,retain) IBOutlet UIButton *transferAtMarlboroughBtn;
@property(nonatomic,retain) IBOutlet UIButton *abbeydaleBtn;
@property(nonatomic,retain) IBOutlet UIButton *endCommuteBtn;

@property(nonatomic,retain) NSDate *lastRecordedTime;

@end
