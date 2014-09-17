//
//  MainMenu.h
//  Early Reader
//
//  Created by idomechi on 7/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubMenu.h"

@interface MainMenu : UIView {
	
	UIView * layoutView;
	UIButton * number;
	UIButton * shape;
	UIButton * measurement;
	UIButton * addsubstract;
	UIButton * time;
	SubMenu * submenu;
	BOOL animation;
}

- (void) loadRes;
- (void) comesBack;
- (void) nextScreenTranslation:(int) button_num;

@property (nonatomic) BOOL animation;
@end
