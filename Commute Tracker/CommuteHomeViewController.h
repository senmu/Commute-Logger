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

- (IBAction)startCommute:(id)sender;
- (IBAction)transferAt8thSt:(id)sender;
- (IBAction)mcknightTrain:(id)sender;
- (IBAction)transferAtMarlborough:(id)sender;
- (IBAction)abbeydaleBus:(id)sender;
- (IBAction)endCommute:(id)sender;

@end
