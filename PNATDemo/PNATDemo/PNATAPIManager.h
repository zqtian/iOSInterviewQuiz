//
//  PNATAPIManager.h
//  PNATDemo
//
//  Created by 张泉 on 15/9/17.
//  Copyright © 2015年 张泉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PhoneNumberAttribution;

typedef NS_ENUM(NSUInteger, APIRequestStatus) {
    APIRequestStatusOK,
    APIRequestStatusConnectionFailure,
    APIRequestStatusDataFailure,
    APIRequestStatusJSONFailure,
    APIRequestStatusUnknownFailure
};

@interface PNATAPIManager : NSObject

+ (void)requestPhoneNumberAttributionWithPhoneNumberString: (NSString *)phoneNumberString completionHandler:(void (^)(PhoneNumberAttribution *attribution, APIRequestStatus status)) handler;

@end
