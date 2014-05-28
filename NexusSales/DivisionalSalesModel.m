//
//  DivisionalSalesModel.m
//  NexusSales
//
//  Created by Dean Becker on 12/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import "DivisionalSalesModel.h"

@implementation DivisionalSalesModel
{
    NSMutableArray *salesData;
    NSDate *lastUpdated;
}

-(unsigned long)count
{
    return salesData.count;
}

-(NSArray *)fetch
{
    NSTimeInterval diff = [[NSDate date] timeIntervalSinceDate: lastUpdated];
    if (diff > 300 || lastUpdated == nil) {
        NSURL *url = [NSURL URLWithString:@"https://services.nexusinds.com/SalesData/SalesData.svc/GetSalesIntakeData/"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        if (data != nil) {
            NSError *err;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            NSArray *jsonObject = [json objectForKey:@"GetSalesIntakeDataResult"];
            salesData = [[NSMutableArray alloc] initWithCapacity:jsonObject.count];
            
            for (NSDictionary* divDetail in jsonObject) {
                DivisionalData *data = [[DivisionalData alloc] init];
                data.Division = [divDetail objectForKey:@"Division"];
                data.Sales = [[divDetail objectForKey:@"Sales"] floatValue];
                data.Intake = [[divDetail objectForKey:@"Intake"] floatValue];
                data.Shipped = [[divDetail objectForKey:@"Shipped"] floatValue];
                
                [salesData addObject:data];
            }
            
            lastUpdated = [NSDate date];
        }
    }
    return salesData;
}

-(DivisionalData *)getItemAtIndex:(long)index
{
    return [salesData objectAtIndex:index];
}

@end
