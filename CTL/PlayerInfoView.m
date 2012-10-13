//
//  PlayerInfoView.m
//  ctl
//
//  Created by Oskar Wirén on 10/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerInfoView.h"

@implementation PlayerInfoView

@synthesize thumbnailImageView;
@synthesize futureScoreLabel;
@synthesize currentScoreLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlayerInfoView" owner:self options:nil];    
        self = [nib objectAtIndex:0];
        self.frame = frame;
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
