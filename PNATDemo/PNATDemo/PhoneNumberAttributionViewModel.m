//
//  PhoneNumberAttributionViewModel.m
//  PNATDemo
//
//  Created by 张泉 on 15/9/15.
//  Copyright © 2015年 张泉. All rights reserved.
//

#import "PhoneNumberAttributionViewModel.h"
#import "PhoneNumberAttribution.h"
#import "PNATAPIManager.h"

@interface PhoneNumberAttributionViewModel ()

@property (nonatomic, readwrite, assign, getter=isPhoneNumberValid) BOOL phoneNumberValid;
@property (nonatomic, readwrite, strong) NSString *carrierString;
@property (nonatomic, readwrite, strong) NSString *provinceString;
@property (nonatomic, readwrite, strong) NSString *cityString;
@property (nonatomic, readwrite, strong) NSString *simSuitString;
@property (nonatomic, readwrite, strong) NSString *queryStatusString;

@property (nonatomic, strong) PhoneNumberAttribution *phoneNumberAttribution;

@end

@implementation PhoneNumberAttributionViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _phoneNumberAttribution = [[PhoneNumberAttribution alloc] init];
    }
    return self;
}

- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber {
    self = [super init];
    if (self) {
        _phoneNumberString = phoneNumber;
        _phoneNumberAttribution = [[PhoneNumberAttribution alloc] initWithPhoneNumber:phoneNumber];
    }
    
    return self;
}

#pragma mark - Setter & Getter

- (void)setPhoneNumberString:(NSString *)phoneNumberString {
    _phoneNumberString = [phoneNumberString copy];
    
    self.phoneNumberValid = [self isPhoneNumberValid];
//    self.provinceString = nil;
//    self.cityString = nil;
//    self.carrierString = nil;
//    self.simSuitString = nil;
}

- (NSString *)carrierString {
    switch (self.phoneNumberAttribution.carrier) {
        case CarrierChinaMobile:
            return @"中国移动";
            break;
            
        case CarrierChinaUnicom:
            return @"中国联通";
            break;
            
        case CarrierChinaTelcom:
            return @"中国电信";
            break;
            
        case CarrierOthers:
            return @"其他";
            break;
            
        default:
            return nil;
            break;
    }
}


- (BOOL)isPhoneNumberValid {
    if (self.phoneNumberString.length == 11 && self.phoneNumberString.longLongValue > 10000000000) {
        return YES;
    }
    
    return NO;
}

- (void)setPhoneNumberAttribution:(PhoneNumberAttribution *)phoneNumberAttribution {
    [self.phoneNumberAttribution updateWithPhoneNumberAttribution:phoneNumberAttribution];
    
    [self refreshViewModel];
}

#pragma mark - Instance Methods

- (void)refreshViewModel {
    self.phoneNumberString = self.phoneNumberAttribution.phoneNumber;
    self.provinceString = self.phoneNumberAttribution.province;
    self.cityString = self.phoneNumberAttribution.city;
    self.carrierString = [self carrierString];
    self.simSuitString = self.phoneNumberAttribution.simSuit;
}

//- (void)updateAttribution: (PhoneNumberAttribution *)attribution {
//    [self.phoneNumberAttribution updateWithPhoneNumberAttribution:attribution];
//    
//    self.phoneNumberString = attribution.phoneNumber;
//    self.provinceString = attribution.province;
//    self.cityString = attribution.city;
////    self.carrierString = self.carrierString;
//    
//}

- (void)queryPhoneNumberAttribution {
    if (self.isPhoneNumberValid) {
        self.queryStatusString = @"查询中 ...";
        [PNATAPIManager requestPhoneNumberAttributionWithPhoneNumberString:self.phoneNumberString completionHandler:^(PhoneNumberAttribution *attribution, APIRequestStatus status) {
            if (status == APIRequestStatusOK && attribution) {
                self.phoneNumberAttribution = attribution;
                self.queryStatusString = @"查询成功 ...";
            } else {
                self.queryStatusString = @"查询失败 ...";
            }
        }];
    }
}

@end
