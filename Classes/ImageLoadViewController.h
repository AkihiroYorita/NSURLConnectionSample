//
//  ImageLoadViewController.h
//  NSURLConnectionSample
//
//  Created by いろは クリエイティブ on 10/08/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageLoadViewController : UIViewController {	
	//表示
	UIImageView* imageView_;
	UIImageView* imageView2_;
	//queue
	NSOperationQueue* _queue;
}



@end
