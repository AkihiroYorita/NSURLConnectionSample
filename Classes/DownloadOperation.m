//
//  DownloadOperation.m
//  NSURLConnectionSample
//
//  Created by いろは クリエイティブ on 10/08/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
/*
#import "DownloadOperation.h"


@implementation DownloadOperation
@synthesize imageData;
@synthesize image;


+ (BOOL)automaticallyNotifiesObserversForKey:(NSString*)key
{
	if ([key isEqualToString:@"isExecuting"] || 
        [key isEqualToString:@"isFinished"])
    {
		return YES;
	}
	
	return [super automaticallyNotifiesObserversForKey:key];
}

- (id)initWithRequest:(NSURLRequest*)request
{
    if (![super init]) {
        return nil;
    }
    
    // インスタンス変数を初期化する
	_isExecuting = NO;
	_isFinished = NO;
	NSLog(@"init");
    
    return self;
}

//-------------------------------------------------------------------------------------//
#pragma mark -- Operating --
//-------------------------------------------------------------------------------------//


- (void)start
{
	url = [NSURL URLWithString:@"http://k.yimg.jp/images/top/sp/logo.gif"];
	request = [NSURLRequest requestWithURL:url];
	connection1 = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection1 start];
		NSLog(@"down");
}




//-------------------------------------------------------------------------------------//
#pragma mark -- NSURLConnection delegate --
//-------------------------------------------------------------------------------------//

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	self.imageData = [[[NSMutableData alloc]init]autorelease];
	NSLog(@"hello");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[self.imageData appendData:data];
	NSLog(@"hello1");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	self.image = [UIImage imageWithData:self.imageData];

	
	NSLog(@"hello2");
}

@end
*/

/*
 DownloadOperation.m
 
 Author: Makoto Kinoshita
 
 Copyright 2009 HMDT. All rights reserved.
 */

#import "DownloadOperation.h"

@implementation DownloadOperation

// Property
@synthesize data = _data;
@synthesize index;

//-------------------------------------------------------------------------------------//
#pragma mark -- Initialize --
//-------------------------------------------------------------------------------------//

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString*)key
{
	if ([key isEqualToString:@"isExecuting"] || 
        [key isEqualToString:@"isFinished"])
    {
		return YES;
	}
	
	return [super automaticallyNotifiesObserversForKey:key];
}

- (id)initWithRequest:(NSURLRequest*)request
{
    if (![super init]) {
        return nil;
    }
    
    // インスタンス変数を初期化する
    _request = [request retain];
    _data = [[NSMutableData data] retain];
	_isExecuting = NO;
	_isFinished = NO;
    
    return self;
}

- (void)dealloc
{
	// インスタンス変数を解放する
    [_request release], _request = nil;
	[_connection cancel], [_connection release], _connection = nil;
	[_data release], _data = nil;
	
	// 親クラスのメソッドを呼び出す
	[super dealloc];
}

//-------------------------------------------------------------------------------------//
#pragma mark -- Operating --
//-------------------------------------------------------------------------------------//

- (BOOL)isConcurrent
{
	return YES;
}

- (BOOL)isExecuting
{
	return _isExecuting;
}

- (BOOL)isFinished
{
	return _isFinished;
}

- (void)start
{
	// ダウンロードを開始する
	if (![self isCancelled]) {
        // フラグを設定する
        [self setValue:[NSNumber numberWithBool:YES] forKey:@"isExecuting"];
        
        // コネクションを作成する
		[NSURLConnection connectionWithRequest:_request delegate:self];
		NSLog(@"start");
	}
}

- (void)cancel
{
	// 処理をキャンセルする
	[_connection cancel], _connection = nil;
    [self setValue:[NSNumber numberWithBool:NO] forKey:@"isExecuting"];
    [self setValue:[NSNumber numberWithBool:YES] forKey:@"isFinished"];
    
	// 親クラスのメソッドを呼び出す
	[super cancel];
}

//-------------------------------------------------------------------------------------//
#pragma mark -- NSURLConnection delegate --
//-------------------------------------------------------------------------------------//

- (void)connection:(NSURLConnection*)connection
	didReceiveData:(NSData*)data
{
	// データを追加する
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    // フラグを設定する
    _connection = nil;
    [self setValue:[NSNumber numberWithBool:NO] forKey:@"isExecuting"];
    [self setValue:[NSNumber numberWithBool:YES] forKey:@"isFinished"];
}

- (void)connection:(NSURLConnection*)connection
  didFailWithError:(NSError*)error
{
    // フラグを設定する
    _connection = nil;
    [self setValue:[NSNumber numberWithBool:NO] forKey:@"isExecuting"];
    [self setValue:[NSNumber numberWithBool:YES] forKey:@"isFinished"];
	NSLog(@"connect");
}

@end
