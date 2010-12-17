//
//  BasicWebpage.h
//  iDownloader
//
//  Created by Sebastian Hansack on 14.12.10.
//  Copyright 2010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hoster.h"

@interface BasicWebpage : NSObject {
    NSURL * url;
    Hoster * hoster;
}

@property (nonatomic, retain) NSURL * url;
@property (nonatomic, retain) Hoster * hoster;


- (IBAction)startDownloadingURL:(id)sender;
- (NSArray *)getLinks;

@end


