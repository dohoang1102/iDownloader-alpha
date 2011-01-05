//
//  rapidshare.com.m
//  iDownloader
//
//  Created by Sebastian Hansack on 01.01.11.
//  Copyright 2011. All rights reserved.
//

#import "rapidshare.com.h"
static NSString *const apiInterface = @"http://api.rapidshare.com/cgi-bin/rsapi.cgi?sub=";
static NSString *const apiArgs = @"";

//  example URL:
//  http://rapidshare.com/files/385296836/OGP511.7z
//  host/files/FILEID/FILENAME

@implementation rapidshare_com

@synthesize baseURL;

- (id) initWithURL: (NSURL *) aURL {
	if ( (self = [super init]) ) {
		self.baseURL = aURL;
	}

	return self;
}

- (void) dealloc {
	// Clean-up code here.

	[super dealloc];
}

- (NSArray*) getFileInfo {
	//  example Request:
	//  http://api.rapidshare.com/cgi-bin/rsapi.cgi?sub=checkfiles&files=385296836&filenames=OGP511.7z
	//
	//  example Response:
	//  385296836,OGP511.7z,55767817,866,1,dt,0
	//
	//  1:  File ID     385296836
	//  2:  Filename    OGP511.7z
	//  3:  Size        55767817
	//  4:  Server ID   866
	//  5:  Status Int  1
	//  6:  Short Host  dt
	//  7:  md5         0
    //
    //  DL URL:
    //  http://rs866dt.rapidshare.com/files/385296836/OGP511.7z
    //
	
    NSString *fileid = [[baseURL pathComponents] objectAtIndex:[[baseURL pathComponents] count] - 2];
    NSString *filename = [baseURL lastPathComponent];

    NSString *request = [[NSString alloc] initWithFormat: @"%@checkfiles&files=%@&filenames=%@",apiInterface ,fileid ,filename];
    
    NSURL *requestURL = [[NSURL alloc] initWithString: request];
    
    NSString *responseString = [[NSString alloc] initWithContentsOfURL:requestURL]; 
    
    #ifdef DEBUG
	NSLog(@"Request: %@", request);
    NSLog(@"Response: %@",responseString);
    #endif
    
    return [responseString componentsSeparatedByString: @","]; 
}

- (NSArray *) getDownload {
	NSArray *fileInfo =  [[NSArray alloc] initWithArray:[self getFileInfo]];

	//  Downloading as a free user:
	//      Step 1: Call this function with fileid and filename. You will get "DL:$hostname,$dlauth,$countdown,$md5hex".
	//      Step 2: Call an internal function in your tool, which waits $countdown seconds.
	//      Step 3: Call the server $hostname with download authentication string $dlauth after $countdown seconds. You instantly get the file.
    
    NSString *request = [[NSString alloc] initWithFormat:@"%@download&fileid=%@&filename=%@",apiInterface ,[fileInfo objectAtIndex:0] ,[fileInfo objectAtIndex:1]];
    
    NSURL *requestURL = [[NSURL alloc] initWithString:request];
    
    NSString *responseString = [[NSString alloc ] initWithContentsOfURL:requestURL];
    
    #ifdef DEBUG
	NSLog(@"Request: %@", request);
    NSLog(@"Response: %@",responseString);
    #endif
    
    NSArray *responseArray = [responseString componentsSeparatedByString: @","];
    
    NSDate *downloadAble = [[[NSDate alloc ] init] dateByAddingTimeInterval:[[responseArray objectAtIndex:2] intValue]];
    
    #ifdef DEBUG
    int timer = [[responseArray objectAtIndex:2] intValue];
	NSLog(@"Countdown: %@", timer);
    #endif
    
	//  Downloading as a RapidPro user:
	//      Step 1: Call this function with fileid, filename, login and password.
	//          If you called the right server and "try" is not given, you will instantly receive the file.
	//          If you called the wrong server, or try=1 is given, you will get "DL:$hostname,$dlauth,$countdown,$md5hex". See side note #1.
	//      Step 2: Call the same function on the server $hostname.
	//          You instantly get the file. Since you are a RapidPro user, $dlauth and $countdown are always 0.
}

@end