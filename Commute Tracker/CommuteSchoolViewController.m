//
//  CommuteSchoolViewController.m
//  Commute Tracker
//
//  Created by Sam Lu on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CommuteSchoolViewController.h"
#import "Commute_TrackerAppDelegate.h"


@implementation CommuteSchoolViewController

@synthesize startCommuteBtn, transferAtMarlboroughBtn, cityCentreBtn, transferAt3rdStBtn, crowfootBtn, endCommuteBtn;
@synthesize topLabel;
@synthesize timer, lastRecordedTime;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.lastRecordedTime = nil;
        self.timer = nil;
    }
    return self;
}

- (void)dealloc
{
    [timer release];
    [lastRecordedTime release];
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

#pragma mark - Timer
- (void)updateTimer
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:lastRecordedTime];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    topLabel.text = timeString;
    [dateFormatter release];
}

- (NSString*)getTimeSince:(NSDate*)thisDate
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:thisDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    
    return timeString;
}

#pragma mark - Button actions

- (IBAction)startCommute:(id)sender
{
    NSLog(@"startCommute button pressed");
    startCommuteBtn.enabled = NO;
    [self disableButton:startCommuteBtn];
    
    lastRecordedTime = [[NSDate date]retain];
    
    transferAtMarlboroughBtn.enabled = YES;
    [self enableButton:transferAtMarlboroughBtn];
    
    // Replace the topLabel with a timer
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                      target:self
                                                    selector:@selector(updateTimer)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (IBAction)transferAtMarlborough:(id)sender
{
    NSLog(@"transferAtMarlborough button pressed");
    
    // Record data for previous event
    NSString *duration = [self getTimeSince:lastRecordedTime];
    Commute_TrackerAppDelegate *appDelegate = (Commute_TrackerAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate recordEventWithDate:lastRecordedTime forSession:@"Commute to School" event:@"Home to Marlborough LRT (via 45-Applewood)" duration:duration];
    
    // Reset the timer
    [timer invalidate];
    timer = nil;
    // Reset lastRecordedTime
    lastRecordedTime = [[NSDate date]retain];
    [self updateTimer];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                             target:self
                                           selector:@selector(updateTimer)
                                           userInfo:nil
                                            repeats:YES];
    
    transferAtMarlboroughBtn.enabled = NO;
    [self disableButton:transferAtMarlboroughBtn];
    
    cityCentreBtn.enabled = YES;
    [self enableButton:cityCentreBtn];
}

- (IBAction)cityCentreTrain:(id)sender
{
    NSLog(@"cityCentre button pressed");
    
    // Record data for previous event
    NSString *duration = [self getTimeSince:lastRecordedTime];
    Commute_TrackerAppDelegate *appDelegate = (Commute_TrackerAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate recordEventWithDate:lastRecordedTime forSession:@"Commute to School" event:@"Transfer @ Marlborough LRT" duration:duration];
    
    // Reset the timer
    [timer invalidate];
    timer = nil;
    // Reset lastRecordedTime
    lastRecordedTime = [[NSDate date]retain];
    [self updateTimer];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                             target:self
                                           selector:@selector(updateTimer)
                                           userInfo:nil
                                            repeats:YES];
    
    cityCentreBtn.enabled = NO;
    [self disableButton:cityCentreBtn];
    
    transferAt3rdStBtn.enabled = YES;
    [self enableButton:transferAt3rdStBtn];
}

- (IBAction)transferAt3rdSt:(id)sender
{
    NSLog(@"transferAt3rdSt button pressed");
    
    // Record data for previous event
    NSString *duration = [self getTimeSince:lastRecordedTime];
    Commute_TrackerAppDelegate *appDelegate = (Commute_TrackerAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate recordEventWithDate:lastRecordedTime forSession:@"Commute to School" event:@"Marlborough LRT to 3rd St LRT (via 202-City Centre)" duration:duration];
    
    // Reset the timer
    [timer invalidate];
    timer = nil;
    // Reset lastRecordedTime
    lastRecordedTime = [[NSDate date]retain];
    [self updateTimer];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                             target:self
                                           selector:@selector(updateTimer)
                                           userInfo:nil
                                            repeats:YES];
    
    transferAt3rdStBtn.enabled = NO;
    [self disableButton:transferAt3rdStBtn];
    
    crowfootBtn.enabled = YES;
    [self enableButton:crowfootBtn];
}

- (IBAction)crowfootTrain:(id)sender
{
    NSLog(@"crowfoot button pressed");
    
    // Record data for previous event
    NSString *duration = [self getTimeSince:lastRecordedTime];
    Commute_TrackerAppDelegate *appDelegate = (Commute_TrackerAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate recordEventWithDate:lastRecordedTime forSession:@"Commute to School" event:@"Transfer @ 3rd St LRT" duration:duration];
    
    // Reset the timer
    [timer invalidate];
    timer = nil;
    // Reset lastRecordedTime
    lastRecordedTime = [[NSDate date]retain];
    [self updateTimer];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                             target:self
                                           selector:@selector(updateTimer)
                                           userInfo:nil
                                            repeats:YES];
    
    crowfootBtn.enabled = NO;
    [self disableButton:crowfootBtn];
    
    endCommuteBtn.enabled = YES;
    [self enableButton:endCommuteBtn];
}

- (IBAction)endCommute:(id)sender
{
    NSLog(@"endCommute button pressed");
    
    // Record data for previous event
    NSString *duration = [self getTimeSince:lastRecordedTime];
    Commute_TrackerAppDelegate *appDelegate = (Commute_TrackerAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate recordEventWithDate:lastRecordedTime forSession:@"Commute to School" event:@"3rd St LRT to University (via 201-Crowfoot)" duration:duration];
    
    // Reset the timer
    [timer invalidate];
    timer = nil;
    // nil lastRecordedTime
    lastRecordedTime = nil;
    // Reset topLabel
    topLabel.text = @"Press a button to log the time for that part of your commute";
    
    endCommuteBtn.enabled = NO;
    [self disableButton:endCommuteBtn];
    
    startCommuteBtn.enabled = YES;
    [self enableButton:startCommuteBtn];
}

@end
