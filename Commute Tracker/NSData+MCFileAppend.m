//
//  NSData+MCFileAppend.m
//  VersatileTour
//
//  Created by Sam Lu on 11-09-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSData+MCFileAppend.h"

@implementation NSData(MCFileAppend)
- (BOOL)appendToFile:(NSString *)path
{
    NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:path]; 
    if (fh == nil)
        return [self writeToFile:path atomically:YES];
    
    [fh truncateFileAtOffset:[fh seekToEndOfFile]];
    
    [fh writeData:self];
    [fh closeFile];
    return YES;
}
@end

#pragma mark -
@implementation NSString(MCFileAppend)
- (BOOL)appendToFile:(NSString *)path usingEncoding:(NSStringEncoding)encoding
{
    NSData *encoded = [self dataUsingEncoding:encoding];
    return [encoded appendToFile:path];
}
@end