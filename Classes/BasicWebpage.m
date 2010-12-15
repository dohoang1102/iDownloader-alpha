//
//  BasicWebpage.m
//  iDownloader
//
//  Created by Sebastian Hansack on 14.12.10.
//  Copyright 2010. All rights reserved.
//

#import "BasicWebpage.h"


@implementation BasicWebpage

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

- (IBAction)startDownloadingURL:(id)sender {
    NSURL* aURL = [NSURL URLWithString:@"http://www.gamestar.de"];

    [self getWebPageByURL:aURL];
}

- (void)getWebPageByURL:(NSURL *)inputURL {
    
    NSString* aString = [[NSString alloc] initWithContentsOfURL:inputURL];

    
    
    
    //NSLog(@"%@", aString);
}

@end
