//
//  DivisionalCategoryData.h
//  NexusSales
//
//  Created by Dean Becker on 08/10/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DivisionalCategoryData : NSObject

@property (nonatomic, retain) NSString* Category;
@property (nonatomic) float BGIn;
@property (nonatomic) float BGOut;
@property (nonatomic) float NILIn;
@property (nonatomic) float NILOut;
@property (nonatomic) float OtherIn;
@property (nonatomic) float OtherOut;

@end
