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
    
    DivisionalData *data = [self.model getItemAtIndex:indexPath.row];
    cell.DivLabel.text = data.Division;
    cell.InvoicedLabel.text = [self.formatter stringFromNumber: [NSNumber numberWithFloat: data.Sales]];
    cell.IntakeLabel.text = [self.formatter stringFromNumber: [NSNumber numberWithFloat: data.Intake]];
    
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

@end
