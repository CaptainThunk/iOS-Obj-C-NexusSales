//
//  CategoryViewController.m
//  NexusSales
//
//  Created by Dean Becker on 12/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategorySalesModel.h"
#import "JBBarChartView.h"
#import "ChartTooltip.h"
#import "ChartTooltipLabel.h"
#import "InformationLabel.h"

const CGFloat kGraphPadding = 10.0f;
NSNumberFormatter *currencyFormatter;

@interface CategoryViewController () <JBBarChartViewDataSource, JBBarChartViewDelegate>

@property CategorySalesModel *model;

@property (nonatomic, strong) JBBarChartView *chartView;
@property (nonatomic, strong) ChartTooltip *tooltip;
@property (nonatomic, strong) ChartTooltipLabel *tooltipLabel;
@property (nonatomic, strong) InformationLabel *infoLabel;

- (void)setTooltipVisible:(BOOL)visible touchPoint:(CGPoint)touchPoint;

@end

@implementation CategoryViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        currencyFormatter = [[NSNumberFormatter alloc] init];
        [currencyFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        NSString *digitSeperator = [[NSLocale currentLocale] objectForKey: NSLocaleGroupingSeparator];
        [currencyFormatter setGroupingSeparator: digitSeperator];
        [currencyFormatter setCurrencySymbol:@"£"];
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    CGRect graphFrame = [self.GraphView frame];
    self.chartView = [[JBBarChartView alloc] initWithFrame: CGRectMake(graphFrame.origin.x + kGraphPadding, graphFrame.origin.y + kGraphPadding, graphFrame.size.width - kGraphPadding, graphFrame.size.height - kGraphPadding)];
    self.chartView.delegate = self;
    self.chartView.dataSource = self;
    [self.view addSubview: self.chartView];
    [self.chartView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)fetch
{
    if (self.model == nil) {
        self.model = [[CategorySalesModel alloc] init];
    }
    return [self.model fetch];
}

-(NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
{
    return [self.model count];
}

-(CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtAtIndex:(NSUInteger)index
{
    return [[self.model getItemAtIndex: index] Sales];
}

- (void)barChartView:(JBBarChartView *)barChartView didSelectBarAtIndex:(NSUInteger)index touchPoint:(CGPoint)touchPoint
{
    CategoryData *data = [self.model getItemAtIndex: index];
    
    //Show tooltip
    [self setTooltipVisible: true touchPoint: touchPoint];
    [self.tooltipLabel setText: data.Category];
    [self.infoLabel setTitleText: data.Category];
    [self.infoLabel setInfoText: [currencyFormatter stringFromNumber: [NSNumber numberWithFloat: data.Sales]]];
}

- (void)didUnselectBarChartView:(JBBarChartView *)barChartView
{
    [self setTooltipVisible: false touchPoint: CGPointMake(0.0f, 0.0f)];
}

- (UIColor *)barChartView:(JBBarChartView *)barChartView colorForBarViewAtIndex:(NSUInteger)index
{
    return (index % 2 == 0) ? [UIColor colorWithRed:0.376f green:0.51f blue:0.757f alpha:1.0f]
                        : [UIColor colorWithRed:0.737f green:0.741f blue:0.749f alpha:1.0f];
}

- (void)setTooltipVisible:(BOOL)visible touchPoint:(CGPoint)touchPoint
{
    float opacity = visible ? 1.0f : 0.0f;
    
    if (!self.tooltip) {
        self.tooltip = [[ChartTooltip alloc] init];
        [self.view addSubview: self.tooltip];
    }
    
    if (!self.tooltipLabel) {
        self.tooltipLabel = [[ChartTooltipLabel alloc] init];
        [self.view addSubview: self.tooltipLabel];
    }
    
    if (!self.infoLabel) {
        self.infoLabel = [[InformationLabel alloc] initWithFrame: self.HeaderView.frame];
        [self.infoLabel setFrame: self.HeaderView.frame];
        [self.view addSubview: self.infoLabel];
    }
    
    dispatch_block_t adjustPosition = ^{
        // Set tooltip position
        float yAdjustment = -100.0f;
        float xOrigin, yOrigin;
        
        if (touchPoint.x + 50.0f > self.view.frame.size.width) {
            xOrigin = self.view.frame.size.width - 50.0f;
        } else {
            xOrigin = touchPoint.x;
        }

        if ((touchPoint.y - yAdjustment) < 15.0f) {
            yOrigin = 15.0f;
        } else {
            yOrigin = touchPoint.y - yAdjustment;
        }
        
        [self.tooltip setFrame: CGRectMake(xOrigin, yOrigin, 50.0f, 25.0f)];
        [self.tooltipLabel setFrame: CGRectMake(xOrigin, yOrigin, 50.0f, 25.0f)];
    };
    
    dispatch_block_t adjustOpacity = ^{
        // Set opacity
        self.tooltip.alpha = self.tooltipLabel.alpha = self.infoLabel.alpha = opacity;
    };
    
    if (visible) {
        adjustPosition();
    }
    adjustOpacity();
}

@end
