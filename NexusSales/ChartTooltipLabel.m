//
//  ChartTooltipLabel.m
//  NexusSales
//
//  Created by Dean Becker on 14/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import "ChartTooltipLabel.h"

@interface ChartTooltipLabel ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation ChartTooltipLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: CGRectMake(0, 0, 50.0f, 25.0f)];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
        
        self.label = [[UILabel alloc] init];
        self.label.adjustsFontSizeToFitWidth = true;
        self.label.numberOfLines = 1;
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview: self.label];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    [self.label setText: text];
    [self setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.label.frame = self.bounds;
}

@end
