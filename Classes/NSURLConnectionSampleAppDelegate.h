//
//  NSURLConnectionSampleAppDelegate.h
//  NSURLConnectionSample
//
//  Created by いろは クリエイティブ on 10/08/24.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageLoadViewController;

@interface NSURLConnectionSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	ImageLoadViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ImageLoadViewController *viewController;

@end

