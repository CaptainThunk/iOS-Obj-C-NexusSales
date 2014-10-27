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
@property (weak, nonatomic) IBOutlet UILabel *IntakeLabel;
@property (weak, nonatomic) IBOutlet NSObject *FilesOwner;
@property (weak, nonatomic) IBOutlet UILabel *ShippedLabel;
@property (weak, nonatomic) IBOutlet UILabel *LEDIntakeLabel;
@property (weak, nonatomic) IBOutlet UILabel *LEDShippedLabel;
@property (weak, nonatomic) IBOutlet UILabel *InGMLabel;
@property (weak, nonatomic) IBOutlet UILabel *OutGMLabel;
@property (weak, nonatomic) IBOutlet UILabel *LEDInGMLabel;
@property (weak, nonatomic) IBOutlet UILabel *LEDOutGMLabel;

@end
