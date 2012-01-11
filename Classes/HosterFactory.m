//
//  HosterFactory.m
//  iDownloader
//
//  Created by Sebastian Hansack on 02.01.11.
//  Copyright 2011. All rights reserved.
//

#import "HosterFactory.h"


@implementation HosterFactory

- (id) init {
	if ( (self = [super init]) ) {
		// Initialization code here.
	}

	return self;
}

- (void) dealloc {
	// Clean-up code here.

	[super dealloc];
}

- (Hoster *) getHosterFromURL: (NSURL *) aURL {
    
    NSString *host = [aURL host];
    
    #ifdef DEBUG
    NSLog(@"Host: %@", host);
    #endif
    
    
    if ( [host isEqualToString:@"rapidshare.com"]) {
        // Hoster: Rapidshare.com 
       // rapidshare_com *hoster = [[rapidshare_com alloc] initWithURL: aURL];
       // return hoster;
    }         
    
    return nil;
}

@end