

/*
 DownloadOperation.h
 
 Author: Makoto Kinoshita
 
 Copyright 2009 HMDT. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface DownloadOperation : NSOperation
{
    NSURLRequest*       _request;
	NSURLConnection*    _connection;
	NSMutableData*      _data;
    BOOL                _isExecuting, _isFinished;
	int index;
}

// Property
@property (readonly) NSData* data;
@property int index;

// Initialize
- (id)initWithRequest:(NSURLRequest*)request;

@end
