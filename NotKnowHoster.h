//
//  NotKnowHoster.h
//  iDownloader
//
//  Created by Sebastian Hansack on 05.01.11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hoster.h"

//  ToDo
//  Protokoll fehlt noch.

@interface NotKnowHoster : Hoster {

    NSURL *downloadLink;
    
}

- (NSURL *)getDownloadLink;

@end
