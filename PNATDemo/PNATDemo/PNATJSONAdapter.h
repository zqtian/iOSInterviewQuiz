//
//  PNATJSONAdapter.h
//  PNATDemo
//
//  Created by 张泉 on 15/9/17.
//  Copyright © 2015年 张泉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PhoneNumberAttribution;

@interface PNATJSONAdapter : NSObject

+ (PhoneNumberAttribution * _Nullable)phoneNumberAttributionAdaptFromJSON: ( NSObject  * _Nullable )json;

@end
