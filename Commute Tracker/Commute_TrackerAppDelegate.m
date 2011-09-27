//
//  Commute_TrackerAppDelegate.m
//  Commute Tracker
//
//  Created by Sam Lu on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Commute_TrackerAppDelegate.h"
#import "NSData+MCFileAppend.h"

@implementation Commute_TrackerAppDelegate


@synthesize window=_window;

@synthesize tabBarController=_tabBarController;

@synthesize navController=_navController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // Customize the navigation bar
    self.navController.navigationBar.barStyle = UIBarStyleBlack;
    
    // Add the tab bar controller's current view as a subview of the window
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

- (void)recordEventWithDate:(NSDate*)timestamp forSession:(NSString*)theSession event:(NSString*)theEvent duration:(NSString*)theDuration
{
    // prepare timestamp
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss.SSS"];
    NSString *timestampAsString = [dateFormatter stringFromDate:timestamp];
    
    // prepare data
    NSString *userDataEntry = [NSString stringWithFormat:@"\n\"%@\",\"%@\",\"%@\",\"%@\"", timestampAsString, theSession, theEvent, theDuration];
    
    // save to doc
    NSArray *myPathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
	NSString *myPath = [myPathList objectAtIndex:0];
	NSError **err;
    
	myPath = [myPath stringByAppendingPathComponent:@"commuteLog.csv"];
    
	if(![[NSFileManager defaultManager] fileExistsAtPath:myPath]) 
	{
		[[NSFileManager defaultManager] createFileAtPath:myPath contents:nil attributes:nil];
        NSString *csvHeaders = @"Date (yy/mm/dd HH:mm:ss.SSS),Session,Event,Duration";
        NSString *headersAndData = [NSString stringWithFormat:@"%@%@", csvHeaders, userDataEntry];
		[headersAndData writeToFile:myPath atomically:NO encoding:NSUTF8StringEncoding error:err];
	}
	else
	{
        [userDataEntry appendToFile:myPath usingEncoding:NSUTF8StringEncoding];
    }
}

@end
