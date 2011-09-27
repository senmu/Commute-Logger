//
//  FirstViewController.m
//  Commute Tracker
//
//  Created by Sam Lu on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "Commute_TrackerAppDelegate.h"
#import "CommuteHomeViewController.h"

@implementation FirstViewController

@synthesize goingHomeBtn, goingSchoolBtn;

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
}

// start a commute session of commute home
- (IBAction)letsGoHome:(id)sender
{
    Commute_TrackerAppDelegate *appDelegate = (Commute_TrackerAppDelegate *)[[UIApplication sharedApplication] delegate];
    CommuteHomeViewController *commuteHomeView = [[CommuteHomeViewController alloc] initWithNibName:@"CommuteHomeViewController" bundle:nil];
    [appDelegate.navController pushViewController:commuteHomeView animated:YES];
    [commuteHomeView release];
    NSLog(@"home button pressed!");
}

// start a commute session to go home
- (IBAction)letsGoToSchool:(id)sender
{
    NSLog(@"school button pressed!");
}

@end
