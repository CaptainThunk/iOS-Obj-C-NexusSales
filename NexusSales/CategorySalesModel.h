//
//  CategorySalesModel.h
//  NexusSales
//
//  Created by Dean Becker on 13/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataFetchProtocol.h"
#import "CategoryData.h"

@interface CategorySalesModel : NSObject<DataFetchProtocol>

- (unsigned long)count;
- (CategoryData *)getItemAtIndex:(long)index;

@end
