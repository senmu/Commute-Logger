//
//  CommuteSchoolViewController.h
//  Commute Tracker
//
//  Created by Sam Lu on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CommuteSchoolViewController : UIViewController {
    UIButton *startCommuteBtn;
    UIButton *transferAtMarlboroughBtn;
    UIButton *cityCentreBtn;
    UIButton *transferAt3rdStBtn;
    UIButton *crowfootBtn;
    UIButton *endCommuteBtn;
    
    NSDate *lastRecordedTime;
}

@property(nonatomic,retain) IBOutlet UIButton *startCommuteBtn;
@property(nonatomic,retain) IBOutlet UIButton *transferAtMarlboroughBtn;
@property(nonatomic,retain) IBOutlet UIButton *cityCentreBtn;
@property(nonatomic,retain) IBOutlet UIButton *transferAt3rdStBtn;
@property(nonatomic,retain) IBOutlet UIButton *crowfootBtn;
@property(nonatomic,retain) IBOutlet UIButton *endCommuteBtn;

@property(nonatomic,retain) NSDate *lastRecordedTime;

- (IBAction)startCommute:(id)sender;
- (IBAction)transferAtMarlborough:(id)sender;
- (IBAction)cityCentreTrain:(id)sender;
- (IBAction)transferAt3rdSt:(id)sender;
- (IBAction)crowfootTrain:(id)sender;
- (IBAction)endCommute:(id)sender;

@end
