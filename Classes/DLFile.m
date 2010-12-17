//
//  DLFile.m
//  iDownloader
//
//  Created by Sebastian Hansack on 17.12.10.
//  Copyright 2010. All rights reserved.
//

#import "DLFile.h"


@implementation DLFile

- (id)initWithBasicWebpage:(BasicWebpage *) BasicWebpage {
    if ((self = [super init])) {
        self.webpage = BasicWebpage;
    }
    
    return self;
}

- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}

@synthesize webpage, dlurl;

- (void)startDownload {
    
}

- (NSURL *)findDownloadURL {
    BasicWebpage * aWebpage = self.webpage;
    Hoster * hoster = aWebpage.hoster;
    
    NSArray * allLinks = [aWebpage getLinks];
    
    
    
}

@end
