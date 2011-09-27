//
//  CommuteHomeViewController.m
//  Commute Tracker
//
//  Created by Sam Lu on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CommuteHomeViewController.h"


@implementation CommuteHomeViewController

@synthesize startCommuteBtn, transferAt8thStBtn, mcknightBtn, transferAtMarlboroughBtn, abbeydaleBtn, endCommuteBtn;
@synthesize lastRecordedTime;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.lastRecordedTime = nil;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // disable all buttons except "start commute"
    transferAt8thStBtn.enabled = NO;
    mcknightBtn.enabled = NO;
    transferAtMarlboroughBtn.enabled = NO;
    abbeydaleBtn.enabled = NO;
    endCommuteBtn.enabled = NO;
    
    transferAt8thStBtn.alpha = 0.5;
    mcknightBtn.alpha = 0.5;
    transferAtMarlboroughBtn.alpha = 0.5;
    abbeydaleBtn.alpha = 0.5;
    endCommuteBtn.alpha = 0.5;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
