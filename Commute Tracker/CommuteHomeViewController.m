//
//  CommuteHomeViewController.m
//  Commute Tracker
//
//  Created by Sam Lu on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CommuteHomeViewController.h"
#import "Commute_TrackerAppDelegate.h"


@implementation CommuteHomeViewController

@synthesize startCommuteBtn, transferAt8thStBtn, mcknightBtn, transferAtMarlboroughBtn, abbeydaleBtn, endCommuteBtn;
@synthesize topLabel;
@synthesize timer, lastRecordedTime;

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
    
    transferAt8thStBtn.enabled = YES;
    [self enableButton:transferAt8thStBtn];
    
    // Replace the topLabel with a timer
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                             target:self
                                           selector:@selector(updateTimer)
                                           userInfo:nil
                                            repeats:YES];
}

- (IBAction)transferAt8thSt:(id)sender
{
    NSLog(@"transferAt8thSt button pressed");
    
    // Record data for previous event
    NSString *duration = [self getTimeSince:lastRecordedTime];
    Commute_TrackerAppDelegate *appDelegate = (Commute_TrackerAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate recordEventWithDate:lastRecordedTime forSession:@"Commute Home" event:@"University to 8th St LRT (via 201-Somerset)" duration:duration];
    
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
    
    transferAt8thStBtn.enabled = NO;
    [self disableButton:transferAt8thStBtn];
    
    mcknightBtn.enabled = YES;
    [self enableButton:mcknightBtn];
}

- (IBAction)mcknightTrain:(id)sender
{
    NSLog(@"mcknight button pressed");
    
    // Record data for previous event
    NSString *duration = [self getTimeSince:lastRecordedTime];
    Commute_TrackerAppDelegate *appDelegate = (Commute_TrackerAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate recordEventWithDate:lastRecordedTime forSession:@"Commute Home" event:@"Transfer @ 8th St LRT" duration:duration];
    
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
    
    mcknightBtn.enabled = NO;
    [self disableButton:mcknightBtn];
    
    transferAtMarlboroughBtn.enabled = YES;
    [self enableButton:transferAtMarlboroughBtn];
}

- (IBAction)transferAtMarlborough:(id)sender
{
    NSLog(@"transferAtMarlborough button pressed");
    
    // Record data for previous event
    NSString *duration = [self getTimeSince:lastRecordedTime];
    Commute_TrackerAppDelegate *appDelegate = (Commute_TrackerAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate recordEventWithDate:lastRecordedTime forSession:@"Commute Home" event:@"8th St LRT to Marlborough LRT (via 202-McKnight)" duration:duration];
    
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
    
    abbeydaleBtn.enabled = YES;
    [self enableButton:abbeydaleBtn];
}

- (IBAction)abbeydaleBus:(id)sender
{
    NSLog(@"abbeydale button pressed");
    
    // Record data for previous event
    NSString *duration = [self getTimeSince:lastRecordedTime];
    Commute_TrackerAppDelegate *appDelegate = (Commute_TrackerAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate recordEventWithDate:lastRecordedTime forSession:@"Commute Home" event:@"Transfer @ Marlborough LRT" duration:duration];
    
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
    
    abbeydaleBtn.enabled = NO;
    [self disableButton:abbeydaleBtn];
    
    endCommuteBtn.enabled = YES;
    [self enableButton:endCommuteBtn];
}

- (IBAction)endCommute:(id)sender
{
    NSLog(@"endCommute button pressed");
    
    // Record data for previous event
    NSString *duration = [self getTimeSince:lastRecordedTime];
    Commute_TrackerAppDelegate *appDelegate = (Commute_TrackerAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate recordEventWithDate:lastRecordedTime forSession:@"Commute Home" event:@"Marlborough LRT to Home (via 45-Abbeydale)" duration:duration];
    
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
