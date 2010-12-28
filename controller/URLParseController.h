//
//  URLParseController.h
//  iDownloader
//
//  Created by Sebastian Hansack on 28.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicWebpage.h"


@interface URLParseController : NSObject {
@private

    IBOutlet NSTextField * url;
    
}

- (IBAction)startDownloadingURL:(id)sender;

@property (retain, nonatomic) NSTextField * url;


@end