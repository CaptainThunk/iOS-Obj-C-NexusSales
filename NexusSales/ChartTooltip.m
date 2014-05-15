//
//  ChartTooltip.m
//  NexusSales
//
//  Created by Dean Becker on 14/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import "ChartTooltip.h"

@implementation ChartTooltip

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
    [super drawRect: rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor clearColor] set];
    CGContextFillRect(context, rect);
    
    CGContextSaveGState(context);
    {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, CGRectGetMidX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextClosePath(context);
        CGContextSetFillColorWithColor(context, [[UIColor colorWithWhite:1.0f alpha:0.9f] CGColor]);
        CGContextFillPath(context);
    }
    CGContextRestoreGState(context);
}


@end
