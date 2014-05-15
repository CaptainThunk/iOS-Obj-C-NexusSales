//
//  DivisionalSalesModel.h
//  NexusSales
//
//  Created by Dean Becker on 12/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataFetchProtocol.h"
#import "DivisionalData.h"

@interface DivisionalSalesModel : NSObject<DataFetchProtocol>

-(unsigned long)count;
-(DivisionalData *)getItemAtIndex:(long)index;

@end


