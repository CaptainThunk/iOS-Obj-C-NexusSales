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

const CGFloat kGraphPadding = 10.f;

@interface CategoryViewController () <JBBarChartViewDataSource, JBBarChartViewDelegate>

@property CategorySalesModel *model;

@property (nonatomic, strong) JBBarChartView *chartView;
@property (nonatomic, strong) ChartTooltip *tooltip;
@property (nonatomic, strong) ChartTooltipLabel *tooltipLabel;

- (void)setTooltipVisible:(BOOL)visible touchPoint:(CGPoint)touchPoint;

@end

@implementation CategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
}

- (void)didUnselectBarChartView:(JBBarChartView *)barChartView
{
    [self setTooltipVisible: false touchPoint: CGPointMake(0.0f, 0.0f)];
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
    
    dispatch_block_t adjustPosition = ^{
        // Set tooltip position
        float yAdjustment = touchPoint.y / 4.0f;
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
        self.tooltip.alpha = self.tooltipLabel.alpha = opacity;
    };
    
    if (visible) {
        adjustPosition();
    }
    adjustOpacity();
}

@end