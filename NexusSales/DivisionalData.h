//
//  DivisionalData.h
//  NexusSales
//
//  Created by Dean Becker on 12/05/2014.
//  Copyright (c) 2014 Nexus Industries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DivisionalData : NSObject
@property (nonatomic, retain) NSString* Division;
@property (nonatomic) float Sales;
@property (nonatomic) float Intake;
@property (nonatomic) float Shipped;
@property (nonatomic) float LEDIntake;
@property (nonatomic) float LEDShipped;
@property (nonatomic) float IntakeGM;
@property (nonatomic) float ShippedGM;
@property (nonatomic) float LEDIntakeGM;
@property (nonatomic) float LEDShippedGM;
@end
