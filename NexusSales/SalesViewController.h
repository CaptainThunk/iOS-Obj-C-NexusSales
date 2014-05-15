//
//  SalesViewController.h
//  NexusSales
//
//  Created by Dean Becker on 12/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataFetchProtocol.h"

@interface SalesViewController : UIViewController<DataFetchProtocol, UITableViewDelegate, UITableViewDataSource>
{
   IBOutlet UITableView *salesDataTable;
}

@end
