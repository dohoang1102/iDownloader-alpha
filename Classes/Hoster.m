//
//  Hoster.m
//  iDownloader
//
//  Created by Sebastian Hansack on 17.12.10.
//  Copyright 2010. All rights reserved.
//

#import "Hoster.h"


@implementation Hoster

- (id)init:(NSURL *) downloadFile {
    if ((self = [super init])) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}

@end
