//
//  ProgressBarCell.m
//  CTL
//
//  Created by Anders Hassis on 2012-09-23.
//
//

#import "ProgressBarCell.h"

@implementation ProgressBarCell

@synthesize progressView = _progressView;

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

@end
