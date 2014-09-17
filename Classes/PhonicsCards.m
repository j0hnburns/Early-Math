//
//  PhonicsCards.m
//  Early Reader
//
//  Created by idomechi on 7/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PhonicsCards.h"
#import "SubMenu.h"


static int cardsCounts[10] ={10,10,10,10,10,10,10,10,11,10};

@implementation PhonicsCards

@synthesize parent;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		[self loadRes];
    }
    return self;
}

-(void) loadRes
{


	[self  initDatabase];
	
	[self setBackgroundColor:[UIColor whiteColor]];
	
	back = [UIButton buttonWithType:UIButtonTypeCustom];
	back.frame =CGRectMake(0, 0, 52, 53);  
	[back setBackgroundImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
	[back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
	back.showsTouchWhenHighlighted = YES;
	back.center = CGPointMake(40,40);
	

	
	scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	scroll.pagingEnabled =YES;
	scroll.showsHorizontalScrollIndicator =NO;
	scroll.showsVerticalScrollIndicator =NO;
	scroll.delegate =self;
	
	[self addSubview:scroll];
	[self addSubview:back];

	//[scroll release];

	//[back retain];
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	//int page = scrollView.contentOffset.x;
	//if(page < -120 || page> 320*(count_card-1)+120 )
	//	[self back];
	//NSLog(@"%d",page);
}

#define NUM_CAT		5
#define NUM_SETS	2

-(void)setupWords:(int)types withPage:(int) page 
{
	
	NSArray * subviews = [scroll subviews];
	for(UIView * view in subviews)
	{
		[view removeFromSuperview];
	}
	int pos= types*2+page;
	int counts = cardsCounts[pos];//[pictures count]/(NUM_CAT*NUM_SETS);
	int startIndex = 0;
	for(int i=0;i<pos;i++)
		startIndex+=cardsCounts[i];
	
	
	int indexes[counts];
	isRandom = YES;
	if(page == 1 || (types == 3 && page ==0)) isRandom = NO;
	
	//NSLog(@"Start pos %d , %d %d %d",startIndex, types ,page,isRandom);
	if(isRandom)
	{
		for(int i=0;i<counts;i++)
		{
			indexes[i] = i;
		}
	}
	else
	{
		for(int i=0;i<counts;i++) indexes[i]=-1;
		
		for(int i=0;i<counts;i++)
		{
			int randInd = arc4random()%counts;
			while(indexes[randInd]!=-1) randInd = arc4random()%counts;
			indexes[randInd] = i;
		}
	}
	
	for(int i=0;i<counts;i++)
	{
		UIImage * image = [UIImage imageNamed:[pictures objectAtIndex:startIndex+ indexes[i] ]]; 
		UIImageView * view= [[UIImageView alloc] initWithImage:image];
		
		view.frame=CGRectMake(i*320, 0, 320, 480);
		[scroll addSubview:view];
		[view release];
	}
	
	[scroll setContentSize:CGSizeMake(counts*320,480)];
	scroll.contentOffset = CGPointMake(0,0);
	count_card =counts;//[pictures count];
}

-(void) initDatabase
{

	pictures =[NSArray arrayWithObjects:
						@"1.png",@"2.png",@"3.png",@"4.png",@"5.png",@"6.png",@"7.png",@"8.png",@"9.png",@"10.png",
						@"11.png",@"12.png",@"13.png",@"14.png",@"15.png",@"16.png",@"17.png",@"18.png",@"19.png",@"20.png",
						@"1_square.png",@"2_circle.png",@"3_rectangle.png",@"4_diamond.png",@"5_triangle.png",@"6_oval.png",@"7_cone.png",@"8_cube.png",@"9_cylinder.png",@"10_sphere.png",
						@"1_whatshape_triangle.png",@"2_whatshape_cylinder.png",@"3_whatshape_sphere.png",@"4_whatshape_cone.png",@"5_whatshape_cube.png",@"6_whatshape_oval.png",@"7_whatshape_diamond.png",@"8_whatshape_square.png",@"9_whatshape_reqtangle.png",@"10_whatshape_circle.png",
						@"1_concept_light.png",@"2_concept_heavy.png",@"3_concept_tall.png",@"4_concept_short.png",@"5_concept_long.png",@"6_concept_empty.png",@"7_concept_full.png",@"8_concept_halffull.png",@"9_concept_big.png",@"10_concept_small.png",
						@"1_whichis.png",@"2_whichis.png",@"3_whichis.png",@"4_whichis.png",@"5_whichis.png",@"6_whichis.png",@"7_whichis.png",@"8_whichis.png",@"9_whichis.png",@"10_whichis.png",
						@"1_additions.png",@"2_additions.png",@"3_additions.png",@"4_additions.png",@"5_additions.png",@"6_additions.png",@"7_additions.png",@"8_additions.png",@"9_additions.png",@"10_additions.png",
						@"1_substraction.png",@"2_substraction.png",@"3_substraction.png",@"4_substraction.png",@"5_substraction.png",@"6_substraction.png",@"7_substraction.png",@"8_substraction.png",@"9_substraction.png",@"10_substraction.png",
						@"1_keyword_sunday.png",@"2_keyword_monday.png",@"3_keyword_tuesday.png",@"4_keyword_wednesday.png",@"5_keyword_thursday.png",@"6_keyword_friday.png",@"7_keyword_saturday.png",@"8_keyword_morning.png",@"9_keyword_afternoon.png",@"10_keyword_night.png",@"11_keyword_day.png",
						@"1_whatsthetime.png",@"2_whatsthetime.png",@"3_whatsthetime.png",@"4_whatsthetime.png",@"5_whatsthetime.png",@"6_whatsthetime.png",@"7_whatsthetime.png",@"8_whatsthetime.png",@"9_whatsthetime.png",@"10_whatsthetime.png",nil];
	[pictures retain];
	
	

}

-(void) back
{
	SubMenu * menu = (SubMenu*)parent;
	[menu comesBack];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
	//NSLog(@"top");
}

- (void)dealloc {
	
	[scroll removeFromSuperview];
	[back removeFromSuperview];
	[tip removeFromSuperview];
	
	[scroll release];
	[tip release];
	[back release];
	

//	[pictures removeAllObjects];
//	[pictures release];
    [super dealloc];
}


@end
