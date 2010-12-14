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
    NSURL* inputURL = [NSURL URLWithString:@"http://www.gamestar.de"];
    
    
    [self startDownloadingWithURL:inputURL];
}




-(void)startDownloadingWithURL:(NSURL *)inputURL {
    // Create the request.
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[inputURL absoluteURL]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:60.0];
    
    // Create the download with the request and start loading the data.
    NSURLDownload  *theDownload = [[NSURLDownload alloc] initWithRequest:theRequest delegate:self];
    if (!theDownload) {
        // Inform the user that the download failed.
    }
}

- (void)download:(NSURLDownload *)download decideDestinationWithSuggestedFilename:(NSString *)filename {
    NSString *destinationFilename;
    NSString *homeDirectory = NSHomeDirectory();
    
    destinationFilename = [[homeDirectory stringByAppendingPathComponent:@"Desktop"]
                           stringByAppendingPathComponent:filename];
    [download setDestination:destinationFilename allowOverwrite:NO];
}


- (void)download:(NSURLDownload *)download didFailWithError:(NSError *)error {
    // Release the download.
    [download release];
    
    // Inform the user.
    NSLog(@"Download failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)downloadDidFinish:(NSURLDownload *)download {
    // Release the download.
    [download release];
    
    // Do something with the data.
    NSLog(@"%@",@"downloadDidFinish");
}
@end
