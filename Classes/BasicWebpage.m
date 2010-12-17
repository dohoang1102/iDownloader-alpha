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

@synthesize url, hoster;

// TESTING
- (IBAction)startDownloadingURL:(id)sender {
    self.url = [NSURL URLWithString:@"http://www.google.de"];

    [self getLinks];
}

- (NSArray *)getLinks {
    
    //Example to download google's source and print out the urls of all the images
    NSError * error = nil;
    HTMLParser * parser = [[HTMLParser alloc] initWithContentsOfURL:self.url error:&error];
    
    if (error) {
        
        NSLog(@"Error: %@", error);
    }
    HTMLNode * bodyNode = [parser body]; //Find the body tag
    
    NSArray * imageNodes = [bodyNode findChildTags:@"a"]; //Get all the <a href="" />
    NSMutableArray * foundLinks = [[NSMutableArray alloc] init ];
    
    for (HTMLNode * imageNode in imageNodes) { //Loop through all the tags
        
        [foundLinks addObject:[imageNode getAttributeNamed:@"href"]];
        
        //NSLog(@"Found links with href: %@", [imageNode getAttributeNamed:@"href"]); //Echo the src=""
    }
    
    [parser release];
    
    NSArray * fLinks = [[foundLinks copy] autorelease];
    
    return fLinks;
}

@end
