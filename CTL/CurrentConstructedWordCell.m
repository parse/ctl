//
//  CurrentConstructedWordCell.m
//  CTL
//
//  Created by Anders Hassis on 2012-09-23.
//
//

#import "CurrentConstructedWordCell.h"

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

- (void)setupStylesForCell:(UIView *)view borderLeft:(BOOL)borderLeft
{
    CGSize mainViewSize = view.bounds.size;
    CGFloat borderWidth = 1;
    UIColor *borderColor = [UIColor whiteColor];
    if (borderLeft) {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, borderWidth, mainViewSize.height)];
        leftView.opaque = YES;
        leftView.backgroundColor = borderColor;
        
        // for bonus points, set the views' autoresizing mask so they'll stay with the edges:
        leftView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:leftView];
    }
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainViewSize.width, borderWidth)];
    topView.opaque = YES;
    topView.backgroundColor = borderColor;
    
    // for bonus points, set the views' autoresizing mask so they'll stay with the edges:
    topView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
    
    [view addSubview:topView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, mainViewSize.height-borderWidth, mainViewSize.width, borderWidth)];
    bottomView.opaque = YES;
    bottomView.backgroundColor = borderColor;
    
    // for bonus points, set the views' autoresizing mask so they'll stay with the edges:
    bottomView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
    
    [view addSubview:bottomView];
}

// @TODO: Do it some other way...
- (void)awakeFromNib
{
    UIView *view;
    UIFont *f = [UIFont fontWithName:@"Visitor TT1 BRK" size:45];
    
    for (NSInteger i = 1; i<=6; i++) {
        view = (UIView *)[self viewWithTag:i];
        
        if (i != 1) {
            [self setupStylesForCell:view borderLeft:YES];
        } else {
            [self setupStylesForCell:view borderLeft:NO];
        }
        
        UIButton *button = (UIButton *)view;
        [[button titleLabel] setFont:f];
    }
}

@end
