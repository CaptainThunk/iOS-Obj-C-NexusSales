//
//  DivisionalSalesCell.h
//  NexusSales
//
//  Created by Dean Becker on 13/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DivisionalSalesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *DivLabel;
@property (weak, nonatomic) IBOutlet UILabel *InvoicedLabel;
@property (weak, nonatomic) IBOutlet UILabel *IntakeLabel;
@property (weak, nonatomic) IBOutlet NSObject *FilesOwner;

@end
