//
//  URLParseController.h
//  iDownloader
//
//  Created by Sebastian Hansack on 28.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicWebpage.h"
#import "NSURL+iDownloaderExtension.h"

#import "APIs.h"
#import "HosterFactory.h"

@interface URLParseController : NSObject {
@private

    IBOutlet NSTextField * tfUrl;
    
}

- (IBAction)startDownloadingURL:(id)sender;

@property (retain, nonatomic) NSTextField * tfUrl;


@end
