//
//  BasicWebpage.m
//  iDownloader
//
//  Created by Sebastian Hansack on 14.12.10.
//  Copyright 2010. All rights reserved.
//

#import "BasicWebpage.h"
#import "HTMLParser.h"

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

// TESTING
- (IBAction)startDownloadingURL:(id)sender {
    NSURL * aURL = [NSURL URLWithString:@"http://www.google.de"];

    [self getLinksByURL:aURL];
}

- (NSArray *)getLinksByURL:(NSURL *)inputURL {
    
    //Example to download google's source and print out the urls of all the images
    NSError * error = nil;
    HTMLParser * parser = [[HTMLParser alloc] initWithContentsOfURL:inputURL error:&error];
    
    if (error) {
        
        NSLog(@"Error: %@", error);
    }
    HTMLNode * bodyNode = [parser body]; //Find the body tag
    
    NSArray * imageNodes = [bodyNode findChildTags:@"a"]; //Get all the <a href="" />
    NSMutableArray * foundLinks = [[NSArray alloc] init ];
    
    for (HTMLNode * imageNode in imageNodes) { //Loop through all the tags
        
        [foundLinks addObject:imageNode];
        //NSLog(@"Found links with href: %@", [imageNode getAttributeNamed:@"href"]); //Echo the src=""
    }
    
    [parser release];
    
    NSArray * fLinks = [NSArray arrayWithArray:foundLinks];
    
    return fLinks;
}

@end
