//
//  DownloadItem.m
//  iDownloader
//
//  Created by Sebastian Hansack on 17.12.10.
//  Copyright 2010. All rights reserved.
//

#import "DownloadItem.h"

@interface DownloadItem (Private)
- (void) startWgetTask;
- (void) stopWgetTask;
- (NSString *) wgetPath;
- (NSArray *) getArgument;
- (void) backupWgetrc;
- (void) updateWgetrc;
- (void) restoreWgetrc;
- (void) removeFromNotificationCenter;
- (void) finish;
- (void) parseLog: (NSString *) str;
- (void) log: (NSString *) str;
- (void) parseSavedFilePath;

@end

@implementation DownloadItem

- (id) init {
	if ( (self = [super init]) ) {
		// Initialization code here.
	}

	return self;
}

- (void) dealloc {
	// Clean-up code here.

	[super dealloc];
}

- (NSString *) fileName {
	if (url) {
		return [url lastPathComponent];
	}
	else {
		return nil;
	}
}

- (NSString *) lastLogLine {
	return lastLogLine;
}

- (BOOL) isDownloading {
	if (self && wgetTask) {
		[wgetTask isRunning];
	}
	else {
		return NO;
	}

	return NO;
}

- (NSImage *) icon {
	if (!url) {
		return nil;
	}

	NSString *extension = [url pathExtension];

	if (!extension) {
		return nil;
	}

	return [[NSWorkspace sharedWorkspace] iconForFileType: extension];
}

- (void) startStop {
	NSLog(@"DownloadItem::startStop");

	if ([self isDownloading]) {
		[status setString: @"canceled"];
		[self setValue: status forKey: @"status"];
		[self stopDownload];
	}
	else {
	}
}

- (void) startDownload {
}

- (void) stopDownload {
}

- (void) finish {
}

- (void) startWgetTask {
}

- (void) stopWgetTask {
}

- (NSString *) wgetPath {
}

- (void) parseSavedFilePath {
}

@end