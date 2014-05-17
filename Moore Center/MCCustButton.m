//
//  MCCustButton.m
//  Moore Center
//
//  Created by Hackademy on 5/17/14.
//  Copyright (c) 2014 Moore Center. All rights reserved.
//

#import "MCCustButton.h"

@implementation MCCustButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Blue
    UIColor* color1 = [UIColor colorWithRed: 0.157 green: 0.424 blue: 0.576 alpha: 1];
    // Yellow
    UIColor* color2 = [UIColor colorWithRed: 0.992 green: 0.745 blue: 0.122 alpha: 1];
    // Dark blue
    UIColor* color3 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];

    
    CGContextSetFillColorWithColor(context, color1.CGColor);
    self.tintColor = color2;
    
    CGContextFillRect(context, self.bounds);
    
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    
    [self setTitleColor:color3 forState:UIControlStateHighlighted];
    
}

@end
