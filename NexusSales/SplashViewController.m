//
//  SplashViewController.m
//  NexusSales
//
//  Created by Dean Becker on 08/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import "SplashViewController.h"
#import "SalesViewController.h"
#import "CategoryViewController.h"

@interface SplashViewController ()

- (void)segueToMain;

@end

@implementation SplashViewController

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
    self.view.layer.contents = (id)[UIImage imageNamed:@"splash"].CGImage;
    [self segueToMain];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"splashToMain"]) {
        UITabBarController *tab = segue.destinationViewController;
        SalesViewController *salesController = [tab.viewControllers objectAtIndex:0];
        CategoryViewController *categoryController = [tab.viewControllers objectAtIndex:1];
        
        [salesController fetch];
        [categoryController fetch];
    }
}

- (void)segueToMain
{
    [self performSegueWithIdentifier:@"splashToMain" sender:self];
}

@end
