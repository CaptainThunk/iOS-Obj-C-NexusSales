//
//  SalesDetailViewController.h
//  NexusSales
//
//  Created by Dean Becker on 14/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DivisionalData.h"

@interface SalesDetailViewController : UIViewController

@property (nonatomic, retain) DivisionalData *SummaryData;
@property (weak, nonatomic) IBOutlet UILabel *TestLabel;
- (IBAction)TouchBackButton:(id)sender;

@end
