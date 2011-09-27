//
//  SecondViewController.m
//  Commute Tracker
//
//  Created by Sam Lu on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"

#define DATE_LABEL_TAG      1
#define SESSION_LABEL_TAG   2
#define EVENT_LABEL_TAG     3
#define DURATION_LABEL_TAG  4

@implementation SecondViewController

@synthesize myTableView;
@synthesize logOfCommutes;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    myTableView.rowHeight = 100;
    
    // Load tableview with data from csv
    [self loadData];
}

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

- (void)loadData
{
    NSArray *myPathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
	NSString *importPath = [myPathList objectAtIndex:0];
    
	importPath = [importPath stringByAppendingPathComponent:@"commuteLog.csv"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:importPath]) 
	{
        NSData *dataLog = [NSData dataWithContentsOfFile:importPath];
        // assuming data is in UTF8
        NSString *string = [NSString stringWithUTF8String:[dataLog bytes]];
        NSArray *dataArray = [string csvRows];
        logOfCommutes = [[NSMutableArray alloc] initWithArray:dataArray];
        // pop the first entry in logOfCommutes array. These are unnecessary headers
        [logOfCommutes removeObjectAtIndex:0];
        
        // reverse the items in logOfCommutes so that newest items will appear at the top of the table
        dataArray = [[logOfCommutes reverseObjectEnumerator] allObjects];
        [logOfCommutes release];
        logOfCommutes = [[NSMutableArray alloc] initWithArray:dataArray];
	}
	else
	{
        // Add a message in the tableview showing that there are no records yet
        logOfCommutes = [[NSMutableArray alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:@"No records yet", @"", @"", @"", nil], nil];
    }
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of section
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.logOfCommutes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
	
	if(!cell)
	{
		//Create the cell
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"MyCell"] autorelease];
        
		//Create the label
		UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, 20)];
		//Tag the label
		dateLabel.tag = DATE_LABEL_TAG;
		//Add the label to the cell
		[cell.contentView addSubview:dateLabel];
		[dateLabel release];
        
        //Create the label
		UILabel *sessionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, tableView.frame.size.width-20, 20)];
		//Tag the label
		sessionLabel.tag = SESSION_LABEL_TAG;
		//Add the label to the cell
		[cell.contentView addSubview:sessionLabel];
		[sessionLabel release];
        
        //Create the label
		UILabel *eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, tableView.frame.size.width-20, 20)];
		//Tag the label
		eventLabel.tag = EVENT_LABEL_TAG;
		//Add the label to the cell
		[cell.contentView addSubview:eventLabel];
		[eventLabel release];
        
        //Create the label
		UILabel *durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, tableView.frame.size.width-20, 20)];
		//Tag the label
		durationLabel.tag = DURATION_LABEL_TAG;
		//Add the label to the cell
		[cell.contentView addSubview:durationLabel];
		[durationLabel release];
	}
    
	// Get the label for the current cell
	UILabel *dateLabel = (UILabel *)[cell viewWithTag:DATE_LABEL_TAG];
	// Set the label text
	dateLabel.text = [[logOfCommutes objectAtIndex:indexPath.row] objectAtIndex:0];
    // Get the label for the current cell
	UILabel *sessionLabel = (UILabel *)[cell viewWithTag:SESSION_LABEL_TAG];
	// Set the label text
	sessionLabel.text = [[logOfCommutes objectAtIndex:indexPath.row] objectAtIndex:1];
    // Get the label for the current cell
	UILabel *eventLabel = (UILabel *)[cell viewWithTag:EVENT_LABEL_TAG];
	// Set the label text
	eventLabel.text = [[logOfCommutes objectAtIndex:indexPath.row] objectAtIndex:2];
    // Get the label for the current cell
	UILabel *durationLabel = (UILabel *)[cell viewWithTag:DURATION_LABEL_TAG];
	// Set the label text
	durationLabel.text = [[logOfCommutes objectAtIndex:indexPath.row] objectAtIndex:3];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // selecting a cell does nothing yet
}

@end



// ParsingExtensions category to NSString found from: http://www.macresearch.org/cocoa-scientists-part-xxvi-parsing-csv-data

@implementation NSString (ParsingExtensions)

-(NSArray *)csvRows {
    NSMutableArray *rows = [NSMutableArray array];
    
    // Get newline character set
    NSMutableCharacterSet *newlineCharacterSet = (id)[NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
    [newlineCharacterSet formIntersectionWithCharacterSet:[[NSCharacterSet whitespaceCharacterSet] invertedSet]];
    
    // Characters that are important to the parser
    NSMutableCharacterSet *importantCharactersSet = (id)[NSMutableCharacterSet characterSetWithCharactersInString:@",\""];
    [importantCharactersSet formUnionWithCharacterSet:newlineCharacterSet];
    
    // Create scanner, and scan string
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    while ( ![scanner isAtEnd] ) {        
        BOOL insideQuotes = NO;
        BOOL finishedRow = NO;
        NSMutableArray *columns = [NSMutableArray arrayWithCapacity:10];
        NSMutableString *currentColumn = [NSMutableString string];
        while ( !finishedRow ) {
            NSString *tempString;
            if ( [scanner scanUpToCharactersFromSet:importantCharactersSet intoString:&tempString] ) {
                [currentColumn appendString:tempString];
            }
            
            if ( [scanner isAtEnd] ) {
                if ( ![currentColumn isEqualToString:@""] ) [columns addObject:currentColumn];
                finishedRow = YES;
            }
            else if ( [scanner scanCharactersFromSet:newlineCharacterSet intoString:&tempString] ) {
                if ( insideQuotes ) {
                    // Add line break to column text
                    [currentColumn appendString:tempString];
                }
                else {
                    // End of row
                    if ( ![currentColumn isEqualToString:@""] ) [columns addObject:currentColumn];
                    finishedRow = YES;
                }
            }
            else if ( [scanner scanString:@"\"" intoString:NULL] ) {
                if ( insideQuotes && [scanner scanString:@"\"" intoString:NULL] ) {
                    // Replace double quotes with a single quote in the column string.
                    [currentColumn appendString:@"\""]; 
                }
                else {
                    // Start or end of a quoted string.
                    insideQuotes = !insideQuotes;
                }
            }
            else if ( [scanner scanString:@"," intoString:NULL] ) {  
                if ( insideQuotes ) {
                    [currentColumn appendString:@","];
                }
                else {
                    // This is a column separating comma
                    [columns addObject:currentColumn];
                    currentColumn = [NSMutableString string];
                    [scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:NULL];
                }
            }
        }
        if ( [columns count] > 0 ) [rows addObject:columns];
    }
    
    return rows;
}

@end
