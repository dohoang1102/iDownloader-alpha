//
//  iDownloadFile.h
//  iDownloader
//
//  Created by Sebastian Hansack on 31.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CURLHandle/CURLHandle.h>
#import <CURLHandle/CURLHandle+extras.h>

@interface iDownloadFile : NSObject {
    CURLHandle * aCURLHandle;
	
}
- (IBAction)go:(id)sender;


@end
