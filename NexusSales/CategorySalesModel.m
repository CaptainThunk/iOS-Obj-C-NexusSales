//
//  CategorySalesModel.m
//  NexusSales
//
//  Created by Dean Becker on 13/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import "CategorySalesModel.h"

@implementation CategorySalesModel
{
    NSMutableArray *salesData;
    NSDate *lastUpdated;
}

- (NSArray *)fetch
{
    NSTimeInterval diff = [[NSDate date] timeIntervalSinceDate:lastUpdated];
    if (diff > 300 || lastUpdated == nil) {
        NSURL *url = [NSURL URLWithString:@"https://services.nexusinds.com/SalesData/SalesData.svc/GetCategoryData/"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        if (data != nil) {
            NSError *err;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            NSArray *jsonObject = [json objectForKey:@"GetCategoryDataResult"];
            
            salesData = [[NSMutableArray alloc] initWithCapacity:jsonObject.count];
            
            for (NSDictionary* categoryDetail in jsonObject) {
                CategoryData *data = [[CategoryData alloc] init];
                data.Category = [categoryDetail objectForKey:@"Category"];
                data.Sales = [[categoryDetail objectForKey:@"Sales"] floatValue];
                
                [salesData addObject:data];
            }
            
            lastUpdated = [NSDate date];
        }
    }
    
    return salesData;
}

- (unsigned long)count
{
    return [salesData count];
}

- (CategoryData *)getItemAtIndex:(long)index
{
    return [salesData objectAtIndex: index];
}

@end