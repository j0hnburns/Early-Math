//
//  Early_MathAppDelegate.m
//  Early Math
//
//  Created by idomechi on 9/2/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "Early_MathAppDelegate.h"
#import "Early_MathViewController.h"

@implementation Early_MathAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
