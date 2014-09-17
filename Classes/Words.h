//
//  SightWords.h
//  Early Reader
//
//  Created by idomechi on 7/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tips.h"

@interface Words : UIView <UIScrollViewDelegate>{

	UIImageView * main;
	UIImageView * mainNext;
	UIView * parent;
	UIButton * back;
	UIButton * tip;
	
	int category;
	NSMutableArray * sightWords[4];
	NSMutableArray * soundingOut[4];
	NSMutableArray * simpleSentences[4];
	
	UIScrollView * scroll;
	int count;
	Tips * tips;
}

-(void) loadRes;
-(void) initDatabase;
-(void) back;

@property (nonatomic,retain) 	UIView * parent;
@property (nonatomic) 	int category;
@end
