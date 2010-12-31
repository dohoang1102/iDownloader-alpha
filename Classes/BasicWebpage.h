//
//  BasicWebpage.h
//  iDownloader
//
//  Created by Sebastian Hansack on 14.12.10.
//  Copyright 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicWebpage : NSObject {
	NSURL *url;
	NSMutableData *responseData;
	NSMutableArray *links;
}

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSMutableArray *links;

- (id) initWithUrl: (NSURL *) aUrl;

- (void) loadSource;


@end