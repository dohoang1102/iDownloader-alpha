//
//  DLFile.h
//  iDownloader
//
//  Created by Sebastian Hansack on 17.12.10.
//  Copyright 2010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicWebpage.h"
#import "Hoster.h"

@interface DLFile : NSObject {
    BasicWebpage * webpage;
    NSURL * dlurl;
}

@property (nonatomic, retain) BasicWebpage * webpage;
@property (nonatomic, retain) NSURL * dlurl;

-(void)startDownload;
-(NSURL *)findDownloadURL;

@end
