//
//  HosterFactory.h
//  iDownloader
//
//  Created by Sebastian Hansack on 02.01.11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Hoster.h"
#import "APIs.h"


@interface HosterFactory : NSObject {
	@private
}

- (Hoster *) getHosterFromURL: (NSURL *) aURL;

@end