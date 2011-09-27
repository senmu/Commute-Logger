//
//  NSData+MCFileAppend.h
//
//  Created by Jeff Lamarche on 10-08-18.
//  Original source: http://iphonedevelopment.blogspot.com/2010/08/funny-thing-about-old-code.html
//

#import <Foundation/Foundation.h>

@interface NSData(MCFileAppend)
    - (BOOL)appendToFile:(NSString *)path;
@end

@interface NSString(MCFileAppend)
- (BOOL)appendToFile:(NSString *)path usingEncoding:(NSStringEncoding)encoding;
@end