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

- (IBAction)startDownloadingURL:(id)sender {
    NSURL* aURL = [NSURL URLWithString:@"http://www.gamestar.de"];

    [self getWebPageByURL:aURL];
}

- (void)getWebPageByURL:(NSURL *)inputURL {
    
    // NSString* aString = [[NSString alloc] initWithContentsOfURL:inputURL];

    //Example to download google's source and print out the urls of all the images
    NSError * error = nil;
    HTMLParser * parser = [[HTMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"] error:Nil];
    
    if (error) {
    NSLog(@"Error: %@", error);
    return;
    }
    HTMLNode * bodyNode = [parser body]; //Find the body tag
    
    NSArray * imageNodes = [bodyNode findChildTags:@"img"]; //Get all the <img alt="" />
    
    for (HTMLNode * imageNode in imageNodes) { //Loop through all the tags
    NSLog(@"Found image with src: %@", [imageNode getAttributeNamed:@"src"]); //Echo the src=""
    }
    
    [parser release];
    
    
    //NSLog(@"%@", aString);
}

@end
