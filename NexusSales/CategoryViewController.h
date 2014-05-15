//
//  CategoryViewController.h
//  NexusSales
//
//  Created by Dean Becker on 12/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataFetchProtocol.h"

@interface CategoryViewController : UIViewController<DataFetchProtocol>
@property (weak, nonatomic) IBOutlet UIView *GraphView;
@property (weak, nonatomic) IBOutlet UIView *HeaderView;

@end
