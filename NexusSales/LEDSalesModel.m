//
//  LEDSalesModel.m
//  NexusSales
//
//  Created by Dean Becker on 08/10/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import "LEDSalesModel.h"

@implementation LEDSalesModel
{
    NSMutableArray *salesData;
    NSDate *lastUpdated;
    NSArray *urls;
    CategoryModelScope selectedScope;
    CategoryModelScope currentScope;
}

- (instancetype)initWithScope:(CategoryModelScope)scope
{
    if (self = [super init]) {
        selectedScope = scope;
        urls = [NSArray arrayWithObjects:@"https://services.nexusinds.com/SalesData/SalesData.svc/GetCategoryData/LED/Daily",
                @"https://services.nexusinds.com/SalesData/SalesData.svc/GetCategoryData/LED/Monthly",
                nil];
    }
    return self;
}

- (NSArray *)fetch
{
    NSTimeInterval diff = [[NSDate date] timeIntervalSinceDate: lastUpdated];
    if (diff > 300 || lastUpdated == nil || selectedScope != currentScope) {
        NSURL *url = [NSURL URLWithString:[urls objectAtIndex: selectedScope]];
        NSData *jsonData = [NSData dataWithContentsOfURL:url];

        if (jsonData != nil) {
            NSError *err;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
            NSArray *jsonObj = [json objectForKey:@"GetCategoryLEDDataResult"];
            salesData = [[NSMutableArray alloc] initWithCapacity:jsonObj.count];

            for (NSDictionary *detail in jsonObj) {
                DivisionalCategoryData *data = [[DivisionalCategoryData alloc] init];
                data.Category = [detail objectForKey: @"Category"];
                data.BGIn = [[detail objectForKey: @"BGDomesticIn"] floatValue];
                data.BGOut = [[detail objectForKey: @"BGDomesticOut"] floatValue];
                data.NILIn = [[detail objectForKey: @"NILDomesticIn"] floatValue];
                data.NILOut = [[detail objectForKey: @"NILDomesticOut"] floatValue];
                data.OtherIn = [[detail objectForKey: @"OtherIn"] floatValue];
                data.OtherOut = [[detail objectForKey: @"OtherOut"] floatValue];
                [salesData addObject: data];
            }
            
            lastUpdated = [NSDate date];
            currentScope = selectedScope;
        }
    }

    return salesData;
}

- (unsigned long)count
{
    return [salesData count];
}

- (DivisionalCategoryData *)getItemAtIndex:(long)index
{
    return [salesData objectAtIndex: index];
}

- (instancetype)changeScope:(CategoryModelScope)scope
{
    selectedScope = scope;
    [self fetch];
    return self;
}

@end
