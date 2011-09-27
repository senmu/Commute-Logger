//
//  NSData+MCFileAppend.m
//
//  Created by Jeff Lamarche on 10-08-18.
//  Original source: http://iphonedevelopment.blogspot.com/2010/08/funny-thing-about-old-code.html
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