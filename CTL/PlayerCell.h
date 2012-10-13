//
//  PlayerCell.h
//  CTL
//
//  Created by Anders Hassis on 2012-09-23.
//
//

#import <UIKit/UIKit.h>

@interface PlayerCell : UITableViewCell

+ (void)setupStylesForCell:(UIView *)view borderLeft:(BOOL)borderLeft;

@property (nonatomic) NSInteger playerIndex;

@end
