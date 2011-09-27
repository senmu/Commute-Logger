//
//  SecondViewController.h
//  Commute Tracker
//
//  Created by Sam Lu on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecondViewController : UITableViewController {
    UITableView *myTableView;
    NSMutableArray *logOfCommutes;
}

@property(nonatomic,retain) IBOutlet UITableView *myTableView;
@property(nonatomic,retain) NSMutableArray *logOfCommutes;

- (void)loadData;

@end

@interface NSString (ParsingExtensions)
-(NSArray *)csvRows;
@end