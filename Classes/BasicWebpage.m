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

- (id) initWithUrl:(NSURL *)aUrl {
    if ((self = [super init])) {
        self.url = aUrl;
    }
    
    return self;    
}

@synthesize url, hoster, responseData, links;


- (void)loadSource {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (!theConnection) {
        // Inform the user that the connection failed.

    } 
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [responseData release];
    [connection release];
    NSLog(@"Unable to fetch data");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
    NSLog(@"Succeeded! Received %d bytes of data",[responseData
                                                   length]);
    NSError * error = nil;
    HTMLParser * parser = [[HTMLParser alloc] initWithData:responseData error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error);
    }
    HTMLNode * bodyNode = [parser body]; //Find the body tag
    
    NSArray * imageNodes = [bodyNode findChildTags:@"a"]; //Get all the <a href="" />
    NSMutableArray * foundLinks = [[NSMutableArray alloc] init ];
    
    for (HTMLNode * imageNode in imageNodes) { //Loop through all the tags
        
        [foundLinks addObject:[imageNode getAttributeNamed:@"href"]];
        
        // For Debugging
         NSLog(@"Found links with href: %@", [imageNode getAttributeNamed:@"href"]);
    }
    
    [parser release];
    
    self.links = [[foundLinks copy] autorelease];
    
    [connection release];
    [responseData release];
    
}

@end
