//
//  CategoryListViewController.m
//  NexusSales
//
//  Created by Dean Becker on 08/10/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import "CategoryListViewController.h"
#import "LEDSalesModel.h"
#import "CategorySalesCell.h"

@interface CategoryListViewController ()
{
    LEDSalesModel *model;
    UIRefreshControl *refreshControl;
}

@end

@implementation CategoryListViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [categoryDataTable setSeparatorInset: UIEdgeInsetsZero];

    // TableViewDataSource Protocol stuff
    categoryDataTable.dataSource = self;
    categoryDataTable.delegate = self;
    [categoryDataTable reloadData];

    // Setup toolbar
    [self createToolbar];

    // Pull-to-refresh
    UITableViewController *vc = [[UITableViewController alloc] init];
    vc.tableView = categoryDataTable;
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh setTintColor: [UIColor colorWithRed:0.376f green:0.51f blue:0.757f alpha:1.0f]];
    [refresh addTarget:self action:@selector(pullToRefresh:) forControlEvents:UIControlEventValueChanged];

    vc.refreshControl = refreshControl = refresh;

    // Refresh view on initial entry
    [refresh beginRefreshing];
    [categoryDataTable setContentOffset:CGPointMake(0, -refresh.frame.size.height) animated:YES];
    [self performSelectorInBackground:@selector(pullToRefresh:) withObject:refresh];
}

- (void) createToolbar
{
    UIBarButtonItem *dayView = [[UIBarButtonItem alloc] initWithTitle:@"Day" style:UIBarButtonItemStyleBordered target:self action:@selector(changeScope:)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *monthView = [[UIBarButtonItem alloc] initWithTitle:@"Month" style:UIBarButtonItemStyleBordered target:self action:@selector(changeScope:)];

    NSArray *barItems = [NSArray arrayWithObjects:dayView, spacer, monthView, nil];
    [self.toolbar setItems:barItems];
}

- (IBAction)changeScope:(id)sender
{
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    [refreshControl beginRefreshing];
    [categoryDataTable setContentOffset: CGPointMake(0, -refreshControl.frame.size.height) animated:YES];
    [self performSelectorInBackground:@selector(changeScopeAction:) withObject: button.title];
}

- (void)changeScopeAction:(NSString *)buttonTitle
{
    CategoryModelScope scope;
    if ([buttonTitle isEqualToString:@"Day"]) {
        scope = CategoryModelScopeDaily;
    } else {
        scope = CategoryModelScopeMonthly;
    }
    [model changeScope:scope];
    [refreshControl endRefreshing];
    [categoryDataTable reloadData];
}

- (void) pullToRefresh: (id)sender
{
    [self fetch];
    [(UIRefreshControl *)sender endRefreshing];
    [categoryDataTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *) fetch
{
    if (model == nil) {
        model = [[LEDSalesModel alloc] initWithScope:CategoryModelScopeDaily];
    }
    return [model fetch];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - TableViewDelegate


#pragma mark - TableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [model count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdent = @"CatCell";
    CategorySalesCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdent];

    if (!cell) {
        [tableView registerNib: [UINib nibWithNibName: @"CategorySalesCell" bundle:nil] forCellReuseIdentifier:cellIdent];
        cell = [tableView dequeueReusableCellWithIdentifier: cellIdent];
    }
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    [cell setSeparatorInset:UIEdgeInsetsZero];

    DivisionalCategoryData *data = [model getItemAtIndex: indexPath.row];
    cell.CategoryLabel.text = data.Category;

    // BG
    cell.BGInLabel.text = formatLabelData(data.BGIn);
    cell.BGOutLabel.text = formatLabelData(data.BGOut);
    // NIL
    cell.NILInLabel.text = formatLabelData(data.NILIn);
    cell.NILOutLabel.text = formatLabelData(data.NILOut);
    // Other
    cell.OtherInLabel.text = formatLabelData(data.OtherIn);
    cell.OtherOutLabel.text = formatLabelData(data.OtherOut);

    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[[NSBundle mainBundle] loadNibNamed: @"CategorySalesHeaderCell" owner:self options:nil] objectAtIndex:0];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

NSString* formatLabelData(float value)
{
    NSString *labelData;

    if (value >= 1000.0f) {
        labelData = [NSString stringWithFormat: @"£%dK", (int)roundf(value/1000)];
    } else {
        labelData = @"";
    }

    return labelData;
}

@end
