//
//  PNATJSONAdapter.m
//  PNATDemo
//
//  Created by 张泉 on 15/9/17.
//  Copyright © 2015年 张泉. All rights reserved.
//

#import "PNATJSONAdapter.h"
#import "PhoneNumberAttribution.h"

@implementation PNATJSONAdapter

//
//API地址: http://apistore.baidu.com/apiworks/servicedetail/794.html
//
//
//{
//    "errNum": -1,
//    "retMsg": "[186270611x]此号码不是合法的手机号!",
//    "retData": []
//}
//
//{
//    "errNum": 0,
//    "retMsg": "success",
//    "retData": {
//        "phone": "18627061111",
//        "prefix": "1862706",
//        "supplier": "中国联通",
//        "province": "湖北",
//        "city": "武汉",
//        "suit": "186卡"
//    }
//}

+ (PhoneNumberAttribution *)phoneNumberAttributionAdaptFromJSON:(NSObject *)json {
    
    if (json == nil) {
        return nil;
    }
    
    if (![json isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSDictionary *jsonDic = (NSDictionary *)json;
    NSNumber *errNumber = jsonDic[@"errNum"];
    NSString *returnMessage = jsonDic[@"retMsg"];
    if (errNumber && [errNumber isKindOfClass:[NSNumber class]] && returnMessage && [returnMessage isKindOfClass:[NSString class]]) {
        if (errNumber.integerValue != 0 || ![returnMessage isEqualToString:@"success"]) {
            return nil;
        }
        
        NSDictionary *attDetailDataDic = jsonDic[@"retData"];
        if (attDetailDataDic == nil || ![attDetailDataDic isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
        
        NSString *phoneString = attDetailDataDic[@"phone"];
        NSString *carrierString = attDetailDataDic[@"supplier"];
        NSString *provinceString = attDetailDataDic[@"province"];
        NSString *cityString = attDetailDataDic[@"city"];
        NSString *simSuitString = attDetailDataDic[@"suit"];
        
        if (phoneString == nil || ![phoneString isKindOfClass:[NSString class]] ||
            carrierString == nil || ![carrierString isKindOfClass:[NSString class]] ||
            provinceString == nil || ![provinceString isKindOfClass:[NSString class]] ||
            cityString == nil || ![cityString isKindOfClass:[NSString class]]) {
            return nil;
        }
        
        Carrier carrier = CarrierOthers;
        if ([carrierString containsString:@"移动"]) {
            carrier = CarrierChinaMobile;
        } else if ([carrierString containsString:@"联通"]) {
            carrier = CarrierChinaUnicom;
        } else if ([carrierString containsString:@"电信"]) {
            carrier = CarrierChinaTelcom;
        } else {
            carrier = CarrierOthers;
        }
        
        
        PhoneNumberAttribution *attribution = [[PhoneNumberAttribution alloc] initWithPhoneNumber:phoneString carrier:carrier province:provinceString city:cityString simSuit:simSuitString];
        
        return attribution;
        
    } else {
        return nil;
    }
    
    
    
    return nil;
}

@end
