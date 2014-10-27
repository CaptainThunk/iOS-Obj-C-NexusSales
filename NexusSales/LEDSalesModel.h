//
//  LEDSalesModel.h
//  NexusSales
//
//  Created by Dean Becker on 08/10/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataFetchProtocol.h"
#import "DivisionalCategoryData.h"
#import "NexusSalesEnum.h"

@interface LEDSalesModel : NSObject<DataFetchProtocol>

- (instancetype)initWithScope:(CategoryModelScope)scope;
- (unsigned long)count;
- (DivisionalCategoryData *)getItemAtIndex:(long)index;
- (instancetype)changeScope:(CategoryModelScope)scope;

@end
