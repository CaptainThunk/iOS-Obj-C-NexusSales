//
//  InformationLabel.m
//  NexusSales
//
//  Created by Dean Becker on 15/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import "InformationLabel.h"

@interface InformationLabel ()

@property (nonatomic, strong) UILabel *TitleLabel;
@property (nonatomic, strong) UILabel *InfoLabel;

@end

@implementation InformationLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
        
        // Title label initialisation
        self.TitleLabel = [[UILabel alloc] init];
        self.TitleLabel.adjustsFontSizeToFitWidth = true;
        self.TitleLabel.numberOfLines = 1;
        self.TitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.TitleLabel setFont: [UIFont boldSystemFontOfSize: 18.0f]];
        [self addSubview: self.TitleLabel];
        
        // Info label initialisation
        self.InfoLabel = [[UILabel alloc] initWithFrame: frame];
        self.InfoLabel.adjustsFontSizeToFitWidth = true;
        self.InfoLabel.numberOfLines = 1;
        self.InfoLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview: self.InfoLabel];
    }
    return self;
}

- (void)setTitleText:(NSString *)text
{
    [self.TitleLabel setText:text];
    [self setNeedsDisplay];
}

- (void)setInfoText:(NSString *)text
{
    [self.InfoLabel setText:text];
    [self setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.InfoLabel.frame = self.bounds;
    self.TitleLabel.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height / 2.0f);
}

@end
