//
//  PNATAPIManager.m
//  PNATDemo
//
//  Created by 张泉 on 15/9/17.
//  Copyright © 2015年 张泉. All rights reserved.
//

#import "PNATAPIManager.h"
#import "PhoneNumberAttribution.h"
#import "PNATJSONAdapter.h"

@implementation PNATAPIManager


//
//API地址: http://apistore.baidu.com/apiworks/servicedetail/794.html
//

+ (void)requestPhoneNumberAttributionWithPhoneNumberString:(NSString *)phoneNumberString completionHandler:(void (^)(PhoneNumberAttribution *, APIRequestStatus))handler {
    NSString *urlString = [NSString stringWithFormat:@"http://apis.baidu.com/apistore/mobilenumber/mobilenumber?phone=%@", phoneNumberString];
    NSURL *url = [NSURL URLWithString:[urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"62bccb2d9bdc59cd7c55b7232462237a" forHTTPHeaderField:@"apikey"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        PhoneNumberAttribution *attribution = nil;
        APIRequestStatus status = APIRequestStatusUnknownFailure;
        
        if (connectionError) {
            status = APIRequestStatusConnectionFailure;
        } else {
            if (data == nil || data.length == 0) {
                status = APIRequestStatusDataFailure;
            } else {
                attribution = [PNATJSONAdapter phoneNumberAttributionAdaptFromJSON:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]];
                if (attribution == nil) {
                    status = APIRequestStatusJSONFailure;
                } else {
                    status = APIRequestStatusOK;
                }
            }
        }
        
        handler(attribution, status);
    }];
}

@end
