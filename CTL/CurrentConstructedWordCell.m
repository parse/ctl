//
//  CurrentConstructedWordCell.m
//  CTL
//
//  Created by Anders Hassis on 2012-09-23.
//
//

#import "CurrentConstructedWordCell.h"
#import "PlayerCell.h"

@implementation CurrentConstructedWordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// @TODO: Do it some other way...
- (void)awakeFromNib
{
    UIView *view;
    UIFont *f = [UIFont fontWithName:@"Visitor TT1 BRK" size:45];
    
    for (NSInteger i = 1; i<=6; i++) {
        view = (UIView *)[self viewWithTag:i];
        
        if (i != 1) {
            [PlayerCell setupStylesForCell:view borderLeft:YES];
        } else {
            [PlayerCell setupStylesForCell:view borderLeft:NO];
        }
        
        UIButton *button = (UIButton *)view;
        [[button titleLabel] setFont:f];
    }
}

@end
