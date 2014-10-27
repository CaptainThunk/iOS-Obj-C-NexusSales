//
//  SalesViewController.m
//  NexusSales
//
//  Created by Dean Becker on 12/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import "SalesViewController.h"
#import "DivisionalSalesModel.h"
#import "DivisionalSalesCell.h"
#import "SalesDetailViewController.h"

@interface SalesViewController ()

@property DivisionalSalesModel *model;
@property NSNumberFormatter *formatter;

@end

@implementation SalesViewController


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [salesDataTable setSeparatorInset:UIEdgeInsetsZero];

    // Set number formatter
    self.formatter = [[NSNumberFormatter alloc] init];
    [self.formatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *groupSeperator = [[NSLocale currentLocale] objectForKey: NSLocaleGroupingSeparator];
    [self.formatter setGroupingSeparator: groupSeperator];
    [self.formatter setCurrencySymbol:@"£"];
    [self.formatter setMaximumFractionDigits: 0];
    
    // Set data table protocol stuff up
    salesDataTable.dataSource = self;
    salesDataTable.delegate = self;
    [salesDataTable reloadData];
    
    // Setup pull-to-refresh
    UITableViewController *vc = [[UITableViewController alloc] init];
    vc.tableView = salesDataTable;
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh setTintColor: [UIColor colorWithRed:0.376f green:0.51f blue:0.757f alpha:1.0f]];
    [refresh addTarget:self action:@selector(pullToRefresh:) forControlEvents:UIControlEventValueChanged];

    vc.refreshControl = refresh;
}

- (void)pullToRefresh:(id)sender
{
    [self fetch];
    [(UIRefreshControl *)sender endRefreshing];
    [salesDataTable reloadData];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"summaryToDetail"]) {
        SalesDetailViewController *vc = segue.destinationViewController;
        vc.SummaryData = sender;
    }
}


#pragma mark - Data
-(NSArray *)fetch
{
    if (self.model == nil) {
        self.model = [[DivisionalSalesModel alloc] init];
    }
    return [self.model fetch];
}

#pragma mark - TableView Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdent = @"DivCell";
    DivisionalSalesCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdent];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName: @"DivisionalSalesCell" bundle: nil] forCellReuseIdentifier: cellIdent];
        cell = [tableView dequeueReusableCellWithIdentifier: cellIdent];
    }

    [cell setSeparatorInset:UIEdgeInsetsZero];
    
    DivisionalData *data = [self.model getItemAtIndex:indexPath.row];
    cell.DivLabel.text = data.Division;

    // Format numbers and assign to UI element
    // In/Out data
    if (data.Shipped >= 1000.0f) {
        cell.ShippedLabel.text = [NSString stringWithFormat: @"£%dK", (int)roundf(data.Shipped / 1000)];
    } else {
        cell.ShippedLabel.text = @"";
    }
    if (data.Intake >= 1000.0f) {
        cell.IntakeLabel.text = [NSString stringWithFormat: @"£%dK", (int)roundf(data.Intake / 1000)];
    } else {
        cell.IntakeLabel.text = @"";
    }

    // In/Out GM data
    if (data.Shipped >= 1000.0f) {
        int gm = (int)roundf(data.ShippedGM * 100);
        cell.OutGMLabel.text = [NSString stringWithFormat:@"%d%%", abs(gm)];
        cell.OutGMLabel.textColor = gm < 0 ? [UIColor redColor] : [UIColor blackColor];
    } else {
        cell.OutGMLabel.text = @"";
    }
    if (data.Intake >= 1000.0f) {
        int gm = (int)roundf(data.IntakeGM * 100);
        cell.InGMLabel.text = [NSString stringWithFormat:@"%d%%", abs(gm)];
        cell.InGMLabel.textColor = gm < 0 ? [UIColor redColor] : [UIColor blackColor];
    } else {
        cell.InGMLabel.text = @"";
    }

    // LED In/Out data
    if (data.LEDIntake >= 1000.0f) {
        cell.LEDIntakeLabel.text = [NSString stringWithFormat: @"£%dK", (int)roundf(data.LEDIntake / 1000)];
    } else {
        cell.LEDIntakeLabel.text = @"";
    }

    if (data.LEDShipped >= 1000.0f) {
        cell.LEDShippedLabel.text = [NSString stringWithFormat:@"£%dK", (int)roundf(data.LEDShipped / 1000)];
    } else {
        cell.LEDShippedLabel.text = @"";
    }

    // LED In/Out GM data
    if (data.LEDIntake >= 1000.0f) {
        int gm = (int)roundf(data.LEDIntakeGM * 100);
        cell.LEDInGMLabel.text = [NSString stringWithFormat:@"%d%%", abs(gm)];
        cell.LEDInGMLabel.textColor = gm < 0 ? [UIColor redColor] : [UIColor blackColor];
    } else {
        cell.LEDInGMLabel.text = @"";
    }
    if (data.LEDShipped >= 1000.0f) {
        int gm = (int)roundf(data.LEDShippedGM * 100);
        cell.LEDOutGMLabel.text = [NSString stringWithFormat:@"%d%%", abs(gm)];
        cell.LEDOutGMLabel.textColor = gm < 0 ? [UIColor redColor] : [UIColor blackColor];
    } else {
        cell.LEDOutGMLabel.text = @"";
    }

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DivisionalData *data = [self.model getItemAtIndex:indexPath.row];
    [self performSegueWithIdentifier: @"summaryToDetail" sender: data];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DivisionalSalesHeaderCell" owner:self options:nil] objectAtIndex:0];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

@end
