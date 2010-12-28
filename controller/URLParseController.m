//
//  URLParseController.m
//  iDownloader
//
//  Created by Sebastian Hansack on 28.12.10.
//  Copyright 2010. All rights reserved.
//

#import "URLParseController.h"


@implementation URLParseController

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}

@synthesize url;

- (IBAction)startDownloadingURL:(id)sender {
    
    NSURL * aUrl = [self.url stringValue];
    
    // Do not forget to controll the stringValue.
    // insert Code here
    
    BasicWebpage * webpage = [[BasicWebpage alloc] initWithUrl:aUrl];
    
    [webpage loadSource];
    
    
     
}


@end
