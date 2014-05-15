//
//  SalesDetailViewController.m
//  NexusSales
//
//  Created by Dean Becker on 14/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import "SalesDetailViewController.h"

@interface SalesDetailViewController ()

@end

@implementation SalesDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.TestLabel setText: self.SummaryData.Division];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)TouchBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated: true];
}
@end
