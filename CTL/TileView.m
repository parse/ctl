//
//  TileView.m
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TileView.h"

@implementation TileView

@synthesize characterLabel = _characterLabel;
@synthesize backgroundImageView = _backgroundImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
	
    return self;
}

- (id)initAtRow:(NSInteger)row column:(NSInteger)column
{
	// Create frame from row/column
	CGRect frame = CGRectMake(20, 20, 50, 50);
	
	self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = [UIColor redColor];
        // Initialization code
    }
	
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
