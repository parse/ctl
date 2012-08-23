//
//  PlayerCell.h
//  CTL
//
//  Created by Oskar Wirén on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerCell : UIView

@property (nonatomic, strong) IBOutlet UIImageView *thumbnail;
@property (nonatomic, strong) IBOutlet UILabel *currentScore;
@property (nonatomic, strong) IBOutlet UILabel *futureScore;

@end
