//
//  MainMenu.m
//  Early Reader
//
//  Created by idomechi on 7/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"

#define DURATION 0.2

@implementation MainMenu

@synthesize animation;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		[self loadRes];
    }
    return self;
}

#define START_POS		70
#define DELTA_OFFSET	65

- (void)loadRes
{
	
	[self  setBackgroundColor:[UIColor whiteColor]];
	submenu =[[SubMenu alloc] initWithFrame:CGRectMake(320, 0, 320, 480)];
	submenu.parent = self;
	
	layoutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	
	UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_menu_background.png"]];
		
	int y=START_POS;
	number = [UIButton buttonWithType:UIButtonTypeCustom];
	number.frame =CGRectMake(0, 0, 191, 63); 
	[number setBackgroundImage:[UIImage imageNamed:@"1_number_button.png"] forState:UIControlStateNormal];
	[number addTarget:self action:@selector(num) forControlEvents:UIControlEventTouchDown];
	number.showsTouchWhenHighlighted = YES;
	number.center = CGPointMake(160,y);
	y+=DELTA_OFFSET;
	
	shape = [UIButton buttonWithType:UIButtonTypeCustom];
	shape.frame =CGRectMake(0, 0, 191, 63); 
	[shape setBackgroundImage:[UIImage imageNamed:@"2_shape_button.png"] forState:UIControlStateNormal];
	[shape addTarget:self action:@selector(shape) forControlEvents:UIControlEventTouchDown];
	shape.showsTouchWhenHighlighted = YES;
	shape.center = CGPointMake(160,y);
	y+=DELTA_OFFSET;
	
	measurement = [UIButton buttonWithType:UIButtonTypeCustom];
	measurement.frame =CGRectMake(0, 0, 191, 63); 
	[measurement setBackgroundImage:[UIImage imageNamed:@"3_measurement_button.png"] forState:UIControlStateNormal];
	[measurement addTarget:self action:@selector(measurement) forControlEvents:UIControlEventTouchDown];
	measurement.showsTouchWhenHighlighted = YES;
	measurement.center = CGPointMake(160,y);
	y+=DELTA_OFFSET;
	
	addsubstract = [UIButton buttonWithType:UIButtonTypeCustom];
	addsubstract.frame =CGRectMake(0, 0, 191, 63); 
	[addsubstract setBackgroundImage:[UIImage imageNamed:@"4_addsubstract_button.png"] forState:UIControlStateNormal];
	[addsubstract addTarget:self action:@selector(addsubstract) forControlEvents:UIControlEventTouchDown];
	addsubstract.showsTouchWhenHighlighted = YES;
	addsubstract.center = CGPointMake(160,y);
	y+=DELTA_OFFSET;
	
	time = [UIButton buttonWithType:UIButtonTypeCustom];
	time.frame =CGRectMake(0, 0, 191, 63); 
	[time setBackgroundImage:[UIImage imageNamed:@"5_time_button.png"] forState:UIControlStateNormal];
	[time addTarget:self action:@selector(time) forControlEvents:UIControlEventTouchDown];
	time.showsTouchWhenHighlighted = YES;
	time.center = CGPointMake(160,y);

	
	[layoutView addSubview:imgView];
	[layoutView addSubview:number];
	[layoutView addSubview:shape];
	[layoutView addSubview:measurement];
	[layoutView addSubview:addsubstract];
	[layoutView addSubview:time];
	[imgView release];
	
	[self addSubview:layoutView];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}


-(void) num
{
	[self nextScreenTranslation:0];
}

-(void) shape
{
	[self nextScreenTranslation:1];
}

-(void) measurement
{
	[self nextScreenTranslation:2];
}

-(void) addsubstract
{
	[self nextScreenTranslation:3];
}

-(void) time
{
	[self nextScreenTranslation:4];
}




- (void) nextScreenTranslation:(int) button_num
{

		
	if(animation) return;
	
	NSLog(@"start trans");
	animation = YES;
	submenu.alpha = 0;
	submenu.itemNum = button_num;
	[submenu setBackground];
	[UIView beginAnimations:nil context:self];
	[UIView setAnimationDuration:DURATION];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(nexScreenAppear)];
	
	
	
	[self addSubview:submenu];
	//[layoutView removeFromSuperview];
	submenu.frame=CGRectMake(0, 0, 320, 480);
	submenu.alpha = 1;
	
	[UIView commitAnimations];

	
}

-(void)nexScreenAppear
{
	animation = NO;
	//[layoutView removeFromSuperview];
}

- (void) comesBack
{
	@synchronized(self)
	{
		if(animation) return;
		
		animation = YES;
		submenu.alpha = 1;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:DURATION];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(backAppear)];
		

		submenu.frame=CGRectMake(320, 0, 320, 480);
		submenu.alpha = 0;
		//[self addSubview:layoutView];
	
		[UIView commitAnimations];
	}

}

-(void)backAppear
{
	animation = NO;
	[submenu removeFromSuperview];
}

- (void)dealloc {
	[submenu release];
    [super dealloc];
}


@end
