//
//  CategoryListViewController.h
//  NexusSales
//
//  Created by Dean Becker on 08/10/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataFetchProtocol.h"

@interface CategoryListViewController : UIViewController<DataFetchProtocol, UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *categoryDataTable;
}
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end
