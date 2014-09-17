//
//  PhonicsCards.h
//  Early Reader
//
//  Created by idomechi on 7/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tips.h"

@interface PhonicsCards : UIView <UIScrollViewDelegate>{

	UIButton * back;
	UIButton * tip;
	UIView * parent;
	UIScrollView * scroll;
	NSMutableArray * pictures;
	int count_card;
	Tips * tips;
	BOOL isRandom;
}

-(void) loadRes;
-(void) initDatabase;
-(void) back;
-(void)setupWords:(int)types withPage:(int) page;

@property (nonatomic,retain) UIView * parent; 

@end
