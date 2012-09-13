//
//  PlayerCell.h
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerCellView : UIView {
	IBOutlet UIImageView *thumbnailImageView;
	IBOutlet UILabel *currentScoreLabel;
	IBOutlet UILabel *futureScoreLabel;	
}

@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, strong) NSNumber *currentScore;
@property (nonatomic, strong) NSNumber *futureScore;

@end
