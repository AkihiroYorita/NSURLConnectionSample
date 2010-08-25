    //
//  ImageLoadViewController.m
//  NSURLConnectionSample
//
//  Created by いろは クリエイティブ on 10/08/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageLoadViewController.h"


@implementation ImageLoadViewController
@synthesize imageData;
@synthesize image;
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

	NSURL *url = [NSURL URLWithString:@"http://k.yimg.jp/images/top/sp/logo.gif"];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	connection1 = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection1 start];
	imageView_ = [[UIImageView alloc]initWithFrame:CGRectMake(0, 300, 300, 300)];
	[self.view addSubview:imageView_];

	NSURL *url2_ = [NSURL URLWithString:@"http://k.yimg.jp/images/sh/recommend/84_84_2397.jpg"];
	NSURLRequest *request2_ = [NSURLRequest requestWithURL:url2_];
	connection2 = [[NSURLConnection alloc] initWithRequest:request2_ delegate:self];
	
	[connection2 start];
	
//	UIImage* image = [UIImage imageNamed:@"logo.gif"];
	
	imageView2_ = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
	[self.view addSubview:imageView2_];
	
//	imageView_.autoresizingMask = UIViewAutoresizingNone;
//	imageView_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
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
	[imageView_ release];
	[imageView2_ release];
    [super dealloc];
}

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
	
	if ( connection == connection1 ) {
		imageView_.image = self.image;//imageviewにセット
	}
	if ( connection == connection2 ) {
		imageView2_.image = self.image;//imageview２にセット
	}
	
	NSLog(@"hello2");
}

/*
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
	imageView2_.image = self.image;//imageviewにセット
	
	NSLog(@"hello2");
}
*/

@end
