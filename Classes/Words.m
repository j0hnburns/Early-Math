//
//  SightWords.m
//  Early Reader
//
//  Created by idomechi on 7/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Words.h"
#import "SubMenu.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@implementation Words
@synthesize parent, category;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		[self loadRes];
    }
    return self;
}

-(void) loadRes
{
	
	
	//main = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_menu_background.png"]];

	[self setBackgroundColor:[UIColor whiteColor]];
	
	[self initDatabase];
	
	
	back = [UIButton buttonWithType:UIButtonTypeCustom];
	back.frame =CGRectMake(0, 0, 52, 53);  
	[back setBackgroundImage:[UIImage imageNamed:@"back_submenu_button.png"] forState:UIControlStateNormal];
	[back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
	back.showsTouchWhenHighlighted = YES;
	back.center = CGPointMake(40,40);
	
	
	tip = [UIButton buttonWithType:UIButtonTypeCustom];
	tip.frame =CGRectMake(0, 0, 47, 49);  
	[tip setBackgroundImage:[UIImage imageNamed:@"tips_flashcards_button.png"] forState:UIControlStateNormal];
	[tip addTarget:self action:@selector(tip) forControlEvents:UIControlEventTouchDown];
	tip.showsTouchWhenHighlighted = YES;
	tip.center = CGPointMake(40,440);
	
	scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	scroll.pagingEnabled =YES;
	scroll.showsHorizontalScrollIndicator =NO;
	scroll.showsVerticalScrollIndicator =NO;
	scroll.delegate =self;

	//[self addSubview:main];
	[self addSubview:scroll];
	[self addSubview:back];
	[self addSubview:tip];
	
	[back retain];
	[tip retain];
	//[scroll release];
	//[main release];
	
	count = 0;
}

-(void) tip
{
	
	tips = [[Tips alloc] initWithFrame:CGRectMake(0, 0, 320, 480) type:category  target:self];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
	[UIView setAnimationDuration:0.5];
	[scroll removeFromSuperview];
	[back removeFromSuperview];
	[tip removeFromSuperview];
	
	[self addSubview:tips];
	[UIView commitAnimations];
	[tips release];
	
}


-(void) flipBack
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
	[UIView setAnimationDuration:0.5];
	[tips removeFromSuperview];
	
	[self addSubview:scroll];
	[self addSubview:back];
	[self addSubview:tip];
	
	
	[UIView commitAnimations];
	
}
-(void) initDatabase
{
	for(int i=0;i<4;i++)
	{
		sightWords[i] = [[NSMutableArray alloc] init];
		soundingOut[i] = [[NSMutableArray alloc] init];
		simpleSentences[i] = [[NSMutableArray alloc] init];
	}
	
	FMDatabase* db = [FMDatabase databaseWithPath:[[NSBundle mainBundle] pathForResource:@"early_reader" ofType:@"db"]];
    [db open];
	
	
	FMResultSet *rs = [db executeQuery:@"select id, type ,page,name from Words"];

    while ([rs next]) {

		int type = [rs intForColumn:@"type"];
		int page = [rs intForColumn:@"page"];
		NSString* name = [rs stringForColumn:@"name"];
		switch (type) {
			case 1:
				[sightWords[page] addObject:name];
				break;
			case 2:
				[soundingOut[page] addObject:name];
				break;
			case 3:
				[simpleSentences[page] addObject:name];
				break;
			default:
				break;
		}
    }
	
	[rs close];
	[db close];
}


// it dont make a weather but it can be dun in one class inherted from Cards
-(void)setupWords:(int)types withPage:(int) page 
{
	category = types;
	
	NSArray * subviews = [scroll subviews];
	for(UIView * view in subviews)
	{
		[view removeFromSuperview];
	}
	
	NSArray * arr;
	switch (types) {
		case 1:
			arr = sightWords[page];
			break;
		case 2:
			arr = soundingOut[page];
			break;
		case 3:
			arr = simpleSentences[page];
			break;
		default:
			break;
	}
	count =0;

	for(int i=0;i<[arr count];i++)
	{
		NSString * name = [arr objectAtIndex:i];
		UILabel * lable;
		NSArray * innerArr;
		
		switch(types)
		{
			case 1:
				lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 300, 80)];
				lable.textAlignment = UITextAlignmentCenter;
				lable.text = [NSString stringWithFormat:@"%@",name];
				lable.backgroundColor =[UIColor clearColor];
				lable.font = [UIFont fontWithName:@"AppleGothic" size:72];//boldSystemFontOfSize:48];
				[scroll addSubview:lable];
				lable.frame=CGRectMake(i*320+10, 180, 300, 80);
				break;
			case 2:
				innerArr = [name componentsSeparatedByString:@"|"];
				
				lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, 320, 60)];
				lable.textAlignment = UITextAlignmentCenter;
				lable.text = [NSString stringWithFormat:@"%@",[innerArr objectAtIndex:0] ];
				lable.backgroundColor =[UIColor clearColor];
				lable.font = [UIFont fontWithName:@"AppleGothic" size:48];//boldSystemFontOfSize:48];
				[scroll addSubview:lable];
				lable.frame=CGRectMake(i*320, 220, 320, 60);
				[lable release];
				
				
				UILabel * lableBig = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 120)];
				lableBig.textAlignment = UITextAlignmentCenter;
				lableBig.text = [NSString stringWithFormat:@"%@",[innerArr objectAtIndex:1]];
				lableBig.backgroundColor =[UIColor clearColor];
				lableBig.font = [UIFont fontWithName:@"AppleGothic" size:120];//boldSystemFontOfSize:100];
				//[lableBig sizeThatFits:120];
				lableBig.adjustsFontSizeToFitWidth  =YES;
				[scroll addSubview:lableBig];
				lableBig.frame=CGRectMake(i*320, 100, 320, 120);
				[lableBig release];
				break;
			case 3:
				lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 300, 80)];
				lable.textAlignment = UITextAlignmentCenter;
				lable.text = [NSString stringWithFormat:@"%@",name];
				lable.backgroundColor =[UIColor clearColor];
				lable.font = [UIFont fontWithName:@"AppleGothic" size:48];//boldSystemFontOfSize:48];
				[scroll addSubview:lable];
				
				lable.frame=CGRectMake(i*320+10, 120, 300, 160);
				lable.numberOfLines = 3;
				lable.lineBreakMode = UILineBreakModeWordWrap;
				break;
			default:
				break;

		}
	
		
		count++;
	}
	
	
	
	[scroll setContentSize:CGSizeMake(count*320,480)];
	scroll.contentOffset = CGPointMake(0, 0);
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	//int page = scrollView.contentOffset.x;
	//if(page < -120 || page> 320*(count-1)+120 ) [self back];

}

-(void) back
{
	SubMenu * menu = (SubMenu*)parent;
	[menu comesBack];
}

- (void)dealloc {
	
	for(int i=0;i<4;i++)
	{
		[sightWords[i] release];
		[soundingOut[i] release];
		[simpleSentences[i] release];
	}
	[back removeFromSuperview];
	[back release];
	[tip removeFromSuperview];
	[tip release];
	[scroll removeFromSuperview];
	[scroll release];
	
    [super dealloc];
}


@end
