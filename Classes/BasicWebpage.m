//
//  BasicWebpage.m
//  iDownloader
//
//  Created by Sebastian Hansack on 14.12.10.
//  Copyright 2010. All rights reserved.
//

#import "BasicWebpage.h"


@implementation BasicWebpage

- (void) setURLHandle:(CURLHandle *)inURLHandle
{
	[inURLHandle retain];
    [mURLHandle release];
    mURLHandle = inURLHandle;
}

-(NSURL *)url {
    return self.url;
}

-(void)setUrl:(NSURL *)inputURL {
    self.url = inputURL;
}

-(void)setUrlWithString:(NSString *)inputURL {
    
    self.url = [NSURL URLWithString:inputURL];
}

@synthesize header, html, response;

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


- (BasicWebpage*) getByURL:(NSURL*) inputURL {
    
    [self setURLHandle:(CURLHandle *)[]]
    
    BasicWebpage* aWebpage = [[BasicWebpage init] alloc];
    
    NSURL* aURL = [[NSURL init] alloc];
    
    
    
    aWebpage.url = aURL;    
    
    return aWebpage;
}

@end
