//
//  PlayerInfoView.h
//  ctl
//
//  Created by Oskar Wirén on 10/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerInfoView : UIView

@property (nonatomic, strong) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, strong) IBOutlet UILabel *currentScoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *futureScoreLabel;

@end
