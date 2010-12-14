//
//  BasicWebpage.h
//  iDownloader
//
//  Created by Sebastian Hansack on 14.12.10.
//  Copyright 2010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CURLHandle/CURLHandle.h>


@interface BasicWebpage : NSObject {
@private
    NSURL* url;
    NSString* header;
    NSString* html;
    NSString* response;
    
    CURLHandle* mURLHandle;
}
@property ( readwrite, copy ) NSString* header;
@property ( readwrite, copy ) NSString* html;
@property ( readwrite, copy ) NSString* response;

- (BasicWebpage*) getByURL:(NSURL*) url;

@end
