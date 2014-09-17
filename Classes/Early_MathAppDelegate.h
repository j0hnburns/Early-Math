//
//  Early_MathAppDelegate.h
//  Early Math
//
//  Created by idomechi on 9/2/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Early_MathViewController;

@interface Early_MathAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Early_MathViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Early_MathViewController *viewController;

@end

