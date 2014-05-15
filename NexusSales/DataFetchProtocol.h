//
//  DataFetchProtocol.h
//  NexusSales
//
//  Created by Dean Becker on 13/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataFetchProtocol <NSObject>
- (NSArray *)fetch;
@end
