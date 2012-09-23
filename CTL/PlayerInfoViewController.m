//
//  PlayerCell.m
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerInfoViewController.h"

@implementation PlayerInfoViewController

@synthesize currentScore = _currentScore;
@synthesize futureScore = _futureScore;
@synthesize thumbnailImage = _thumbnailImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Override setters to make sure that the labels and imageViews are updated.

- (void)setFutureScore:(NSNumber *)futureScore
{
	_futureScore = futureScore;
	[futureScoreLabel setText:[NSString stringWithFormat:@"%@", _futureScore]];
}

- (void)setCurrentScore:(NSNumber *)currentScore
{
	_currentScore = currentScore;
	[futureScoreLabel setText:[NSString stringWithFormat:@"%@", _currentScore]];
}

- (void)setThumbnailImage:(UIImage *)thumbnailImage
{
	_thumbnailImage = thumbnailImage;
	[thumbnailImageView setImage:_thumbnailImage];
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
