//
//  BasicWebpage.h
//  iDownloader
//
//  Created by Sebastian Hansack on 14.12.10.
//  Copyright 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicWebpage : NSObject {
@private
    NSURL* url;
    NSString* header;
    NSString* html;
    NSString* response;
    
}
- (IBAction)startDownloadingURL:(id)sender;
- (void)getWebPageByURL:(NSURL *)inputURL;

@end
