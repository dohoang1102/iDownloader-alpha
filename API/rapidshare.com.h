//
//  rapidshare.com.h
//  iDownloader
//
//  Created by Sebastian Hansack on 01.01.11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CURLHandle/CURLHandle.h>
#import <CURLHandle/CURLHandle+extras.h>

#import "Hoster.h"

@interface rapidshare_com : Hoster {
	NSURL *baseURL;
}

@property (nonatomic, retain) NSURL *baseURL;


@end