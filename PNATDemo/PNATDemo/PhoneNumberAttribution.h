//
//  PhoneNumberAttribution.h
//  PNATDemo
//
//  Created by 张泉 on 15/9/15.
//  Copyright © 2015年 张泉. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, Carrier) {
    CarrierOthers,
    CarrierChinaUnicom,
    CarrierChinaMobile,
    CarrierChinaTelcom
};

@interface PhoneNumberAttribution : NSObject

@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, assign) Carrier carrier;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *simSuit;

- (instancetype)initWithPhoneNumber: (NSString *)phoneNumber;
- (instancetype)initWithPhoneNumber: (NSString *)phoneNumber carrier:(Carrier)carrier province: (NSString *)province city: (NSString *)city simSuit: (NSString *)simSuit;

- (void)updateWithPhoneNumberAttribution: (PhoneNumberAttribution *)attribution;
- (void)updateWithWithPhoneNumber: (NSString *)phoneNumber carrier:(Carrier)carrier province: (NSString *)province city: (NSString *)city simSuit: (NSString *)simSuit;

@end
