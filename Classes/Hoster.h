//
//  Hoster.h
//  iDownloader
//
//  Created by Sebastian Hansack on 02.01.11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hoster : NSObject {
	NSDate *StartDownloadAt;
}

- (id) initWithURL: (NSURL *) aURL;

@end

@protocol HosterProtocol

@required
- (NSDate *) getStartingDate;

@optional

@end