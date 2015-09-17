//
//  PhoneNumberAttribution.m
//  PNATDemo
//
//  Created by 张泉 on 15/9/15.
//  Copyright © 2015年 张泉. All rights reserved.
//

#import "PhoneNumberAttribution.h"

@implementation PhoneNumberAttribution

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.phoneNumber = nil;
        self.carrier = CarrierOthers;
        self.province = nil;
        self.city = nil;
        self.simSuit = nil;
    }
    return self;
}

- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber {
    self = [self initWithPhoneNumber:phoneNumber carrier:CarrierOthers province:nil city:nil simSuit:nil];
    
    return self;
}

- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber carrier:(Carrier)carrier province:(NSString *)province city:(NSString *)city simSuit:(NSString *)simSuit{
    self = [super init];
    
    if (self) {
        self.phoneNumber = phoneNumber;
        self.carrier = carrier;
        self.province = province;
        self.city = city;
        self.simSuit = simSuit;
    }
    
    return self;
}

- (void)updateWithPhoneNumberAttribution:(PhoneNumberAttribution *)attribution {
    [self updateWithWithPhoneNumber:attribution.phoneNumber carrier:attribution.carrier province:attribution.province city:attribution.city simSuit:attribution.simSuit];
}

- (void)updateWithWithPhoneNumber:(NSString *)phoneNumber carrier:(Carrier)carrier province:(NSString *)province city:(NSString *)city simSuit:(NSString *)simSuit {
    self.phoneNumber = phoneNumber;
    self.carrier = carrier;
    self.province = province;
    self.city = city;
    self.simSuit = simSuit;
}

@end
