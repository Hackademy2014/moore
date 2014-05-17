//
//  MCNotificationCellTableViewCell.m
//  Moore Center
//
//  Created by Hackademy on 5/17/14.
//  Copyright (c) 2014 Moore Center. All rights reserved.
//

#import "MCNotificationCellTableViewCell.h"

@implementation MCNotificationCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
