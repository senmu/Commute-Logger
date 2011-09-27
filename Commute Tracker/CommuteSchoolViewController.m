//
//  CommuteSchoolViewController.m
//  Commute Tracker
//
//  Created by Sam Lu on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CommuteSchoolViewController.h"


@implementation CommuteSchoolViewController

@synthesize startCommuteBtn, transferAtMarlboroughBtn, cityCentreBtn, transferAt3rdStBtn, crowfootBtn, endCommuteBtn;
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
    transferAtMarlboroughBtn.enabled = NO;
    cityCentreBtn.enabled = NO;
    transferAt3rdStBtn.enabled = NO;
    crowfootBtn.enabled = NO;
    endCommuteBtn.enabled = NO;
    
    transferAtMarlboroughBtn.alpha = 0.5;
    cityCentreBtn.alpha = 0.5;
    transferAt3rdStBtn.alpha = 0.5;
    crowfootBtn.alpha = 0.5;
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

#pragma mark - Animations
- (void)disableButton:(UIButton*)myButton
{
    CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut]; //delete "EaseOut", then push ESC to check out other animation styles
	[UIView setAnimationDuration: 0.5];//how long the animation will take
	[UIView setAnimationDelegate: self];
	myButton.alpha = 0.5; //1.0 to make it visible or 0.0 to make it invisible
	[UIView commitAnimations];
}

- (void)enableButton:(UIButton*)myButton
{
    CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut]; //delete "EaseOut", then push ESC to check out other animation styles
	[UIView setAnimationDuration: 0.5];//how long the animation will take
	[UIView setAnimationDelegate: self];
	myButton.alpha = 1.0; //1.0 to make it visible or 0.0 to make it invisible
	[UIView commitAnimations];
}

#pragma mark - Button actions

- (IBAction)startCommute:(id)sender
{
    NSLog(@"startCommute button pressed");
    startCommuteBtn.enabled = NO;
    [self disableButton:startCommuteBtn];
    
    transferAtMarlboroughBtn.enabled = YES;
    [self enableButton:transferAtMarlboroughBtn];
}

- (IBAction)transferAtMarlborough:(id)sender
{
    NSLog(@"transferAtMarlborough button pressed");
    transferAtMarlboroughBtn.enabled = NO;
    [self disableButton:transferAtMarlboroughBtn];
    
    cityCentreBtn.enabled = YES;
    [self enableButton:cityCentreBtn];
}

- (IBAction)cityCentreTrain:(id)sender
{
    NSLog(@"cityCentre button pressed");
    cityCentreBtn.enabled = NO;
    [self disableButton:cityCentreBtn];
    
    transferAt3rdStBtn.enabled = YES;
    [self enableButton:transferAt3rdStBtn];
}

- (IBAction)transferAt3rdSt:(id)sender
{
    NSLog(@"transferAt3rdSt button pressed");
    transferAt3rdStBtn.enabled = NO;
    [self disableButton:transferAt3rdStBtn];
    
    crowfootBtn.enabled = YES;
    [self enableButton:crowfootBtn];
}

- (IBAction)crowfootTrain:(id)sender
{
    NSLog(@"crowfoot button pressed");
    crowfootBtn.enabled = NO;
    [self disableButton:crowfootBtn];
    
    endCommuteBtn.enabled = YES;
    [self enableButton:endCommuteBtn];
}

- (IBAction)endCommute:(id)sender
{
    NSLog(@"endCommute button pressed");
    endCommuteBtn.enabled = NO;
    [self disableButton:endCommuteBtn];
    
    startCommuteBtn.enabled = YES;
    [self enableButton:startCommuteBtn];
}

@end
