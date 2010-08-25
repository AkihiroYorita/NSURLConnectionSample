//
//  ImageLoadViewController.h
//  NSURLConnectionSample
//
//  Created by いろは クリエイティブ on 10/08/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageLoadViewController : UIViewController {
//connection
	NSMutableData *imageData;
	UIImage *image;
	UIView *view;

	//表示
	UIImageView* imageView_;
	UIImageView* imageView2_;
	NSInteger count_;
	NSURLConnection *connection1;
	NSURLConnection *connection2;
}

@property (nonatomic, retain) NSMutableData *imageData;
@property (nonatomic, retain) UIImage *image;

@end
