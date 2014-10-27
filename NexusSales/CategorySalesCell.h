//
//  CategorySalesCell.h
//  NexusSales
//
//  Created by Dean Becker on 09/10/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategorySalesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *CategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *BGInLabel;
@property (weak, nonatomic) IBOutlet UILabel *BGOutLabel;
@property (weak, nonatomic) IBOutlet UILabel *NILInLabel;
@property (weak, nonatomic) IBOutlet UILabel *NILOutLabel;
@property (weak, nonatomic) IBOutlet UILabel *OtherInLabel;
@property (weak, nonatomic) IBOutlet UILabel *OtherOutLabel;

@end
