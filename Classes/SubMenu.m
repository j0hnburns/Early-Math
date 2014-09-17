//
//  SubMenu.m
//  Early Reader
//
//  Created by idomechi on 7/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SubMenu.h"
#import "MainMenu.h"


#define DURATION 0.5

@implementation SubMenu

@synthesize parent,	itemNum;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		[self loadRes];
    }
    return self;
}


- (void)loadRes
{
	mainview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[self setBackgroundColor:[UIColor whiteColor]];
	//UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_menu_background.png"]];
	
	phonicCard = [[PhonicsCards alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
	phonicCard.parent = self;
	
	UIImageView * header = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"up_alone_footer.png"]];
	//up_alone_footer.png
	
	back = [UIButton buttonWithType:UIButtonTypeCustom];
	back.frame =CGRectMake(0, 0, 52, 53);  
	[back setBackgroundImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
	[back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
	back.showsTouchWhenHighlighted = YES;
	back.center = CGPointMake(40,40);
	
	
	set1 = [UIButton buttonWithType:UIButtonTypeCustom];
	set1.frame =CGRectMake(0, 0, 191, 63); 
	[set1 setBackgroundImage:[UIImage imageNamed:@"1_1_numbers_button.png"] forState:UIControlStateNormal];
	[set1 addTarget:self action:@selector(set1) forControlEvents:UIControlEventTouchDown];
	set1.showsTouchWhenHighlighted = YES;
	set1.center = CGPointMake(160,120);
	
	set2 = [UIButton buttonWithType:UIButtonTypeCustom];
	set2.frame =CGRectMake(0, 0, 191, 63); 
	[set2 setBackgroundImage:[UIImage imageNamed:@"1_2_howmany_button.png"] forState:UIControlStateNormal];
	[set2 addTarget:self action:@selector(set2) forControlEvents:UIControlEventTouchDown];
	set2.showsTouchWhenHighlighted = YES;
	set2.center = CGPointMake(160,185);
	

	//[mainview addSubview:imgView];
	[mainview addSubview:header];
	[mainview addSubview:set1];
	[mainview addSubview:set2];

	[mainview addSubview:back];
	[self addSubview:mainview];
	
	//[imgView release];
}

- (void) setBackground
{
	NSArray * arr = [NSArray arrayWithObjects:@"number_menu_footer.png",@"shape_menu_footer.png",@"measurement_menu_footer.png",@"addsubstract_menu_footer.png",@"time_menu_footer.png",nil];
	NSArray * btn_arr = [NSArray arrayWithObjects:@"1_1_numbers_button.png",@"1_2_howmany_button.png",
						 @"2_1_shapes_button.png",@"2_2_whatshape_button.png",
						 @"3_1_keyconcept_button.png",@"3_2_whichis_button.png",
						 @"4_1_add_button.png",@"4_2_substract_button.png",
						 @"5_1_keywords_button.png",@"5_2_whatsthetime_button.png",nil];
	UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[arr objectAtIndex:itemNum]]];
	[set1 setBackgroundImage:[UIImage imageNamed:[btn_arr objectAtIndex:2*itemNum]] forState:UIControlStateNormal];
	[set2 setBackgroundImage:[UIImage imageNamed:[btn_arr objectAtIndex:2*itemNum+1]] forState:UIControlStateNormal];
	imgView.frame=CGRectMake(0, 480-imgView.frame.size.height, 320, imgView.frame.size.height);
	[mainview addSubview:imgView];
	[imgView release];
}

-(void)set1
{
	[self setStartedPage:0];
	[(PhonicsCards*)currentView setupWords:itemNum withPage:0];
}

-(void)set2
{
	[self setStartedPage:0];
	[(PhonicsCards*)currentView setupWords:itemNum withPage:1];
}




-(void)setStartedPage:(int) page
{


	@synchronized(parent)
	{
		
	MainMenu * mm = (MainMenu*)parent;
	if(mm.animation) return;
	
	mm.animation =YES;

	phonicCard.alpha = 0;
	[UIView beginAnimations:nil context:self];
	[UIView setAnimationDuration:DURATION];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(didFinish)];
	phonicCard.alpha = 1;

	[self addSubview:phonicCard];
	[UIView commitAnimations];
	currentView = phonicCard;

		
	}
	//NSLog(@"start sub page");
	
}

-(void) didFinish
{

	MainMenu * mm = (MainMenu*)parent;
	mm.animation =NO;
	
	[mainview removeFromSuperview];


}

-(void)back
{

	MainMenu * mm = (MainMenu*)parent;
	if(mm.animation) return;
		

	[mm comesBack];
	


}

- (void) comesBack
{

		
	MainMenu * mm = (MainMenu*)parent;
	if(mm.animation) return;

	mm.animation =YES;
	currentView.alpha = 1;
	[UIView beginAnimations:nil context:self];
	[UIView setAnimationDuration:DURATION];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(stopAnimation)];
	currentView.alpha = 0;
	[currentView removeFromSuperview];
	[self addSubview:mainview];
	[UIView commitAnimations];
	
	NSLog(@"appearing JJJJ");
	
	
}

-(void) stopAnimation
{

		MainMenu * mm = (MainMenu*)parent;
		mm.animation =NO;
		[currentView removeFromSuperview];
		NSLog(@"animation no");

}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
	[mainview removeFromSuperview];
	[mainview release];
	
    [super dealloc];
}


@end
