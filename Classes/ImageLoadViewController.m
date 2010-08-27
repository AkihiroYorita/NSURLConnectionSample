    //
//  ImageLoadViewController.m
//  NSURLConnectionSample
//
//  Created by いろは クリエイティブ on 10/08/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageLoadViewController.h"
#import "DownloadOperation.h"

@interface ImageLoadViewController(PrivateMethods)
- (NSOperation *)operationForURLString:(NSString *)urlString
							 withIndex:(int)index;
@end

@implementation ImageLoadViewController


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	// NSOperationQueueを作成する
    _queue = [[NSOperationQueue alloc] init];

	[_queue addOperation:[self operationForURLString:@"http://k.yimg.jp/images/top/sp/logo.gif" withIndex:0]];
	[_queue addOperation:[self operationForURLString:@"http://k.yimg.jp/images/sh/recommend/84_84_2397.jpg" withIndex:1]];

	imageView_ = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
	[self.view addSubview:imageView_];
	
	imageView2_ = [[UIImageView alloc]initWithFrame:CGRectMake(0, 300, 300, 300)];
	[self.view addSubview:imageView2_];
	
	NSLog(@"connect");

}


- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object 
						change:(NSDictionary*)change context:(void*)context
{
	DownloadOperation *op = (DownloadOperation*)object;
	if ( op.index == 0 ) {
		imageView_.image = [UIImage imageWithData:op.data];;//imageviewにセット
	}
	else if ( op.index == 1 ) {
		imageView2_.image = [UIImage imageWithData:op.data];;//imageviewにセット
	}
    
	
    // キー値監視を解除する
    [object removeObserver:self forKeyPath:keyPath];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void)dealloc {
	[_queue release];
	[imageView_ release];
	[imageView2_ release];
    [super dealloc];
}

- (NSOperation *)operationForURLString:(NSString *)urlString
							 withIndex:(int)index
{
	// URLを指定する
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	
	// DownloadOperationを作成する
	DownloadOperation*  operation;
	operation = [[DownloadOperation alloc] initWithRequest:request];
	//	[operation autorelease];
	
	// キー値監視を登録する
	[operation addObserver:self forKeyPath:@"isFinished" 
				   options:NSKeyValueObservingOptionNew context:nil];
	
	operation.index = index;
	return [operation autorelease];
}
@end
