//
//  NSData+MCFileAppend.h
//  VersatileTour
//
//  Created by Sam Lu on 11-09-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(MCFileAppend)
    - (BOOL)appendToFile:(NSString *)path;
@end

@interface NSString(MCFileAppend)
- (BOOL)appendToFile:(NSString *)path usingEncoding:(NSStringEncoding)encoding;
@end