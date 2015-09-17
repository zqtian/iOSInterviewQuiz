//
//  PhoneNumberAttributionViewModel.h
//  PNATDemo
//
//  Created by 张泉 on 15/9/15.
//  Copyright © 2015年 张泉. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PhoneNumberAttributionViewModel : NSObject

@property (nonatomic, readwrite, strong) NSString *phoneNumberString;
@property (nonatomic, readonly, strong) NSString *carrierString;
@property (nonatomic, readonly, strong) NSString *provinceString;
@property (nonatomic, readonly, strong) NSString *cityString;
@property (nonatomic, readonly, strong) NSString *simSuitString;
@property (nonatomic, readonly, strong) NSString *queryStatusString;

@property (nonatomic, readonly, assign, getter=isPhoneNumberValid) BOOL phoneNumberValid;


- (instancetype)initWithPhoneNumber: (NSString *)phoneNumber;

- (void)queryPhoneNumberAttribution;


@end
