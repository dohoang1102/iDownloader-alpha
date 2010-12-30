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

@synthesize tfUrl;

- (IBAction)startDownloadingURL:(id)sender {
    
    // Save the URl as UTF-8
    NSURL * aUrl = [[NSURL alloc] initWithString:[[self.tfUrl stringValue] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    // Debug
    NSLog(@"tfUrl: %@", aUrl);    
    
    // TODO
    // If the url ist noch Valid 
    // do something, this is something to implantete LATER (Word of the Day)
    if (![aUrl hasValidURL]) {
        
    }
    
    // TODO
    // Do not forget to controll the stringValue.
    // insert Code here
    
    BasicWebpage * webpage = [[BasicWebpage alloc] initWithUrl:aUrl];
    
    [webpage loadSource];
    
    
     
}


@end
