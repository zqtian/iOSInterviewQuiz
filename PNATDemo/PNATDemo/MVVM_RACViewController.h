//
//  MVVM_RACViewController.h
//  PNATDemo
//
//  Created by 张泉 on 15/9/15.
//  Copyright © 2015年 张泉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhoneNumberAttributionViewModel;

@interface MVVMViewController : UIViewController

@property (nonatomic, strong) PhoneNumberAttributionViewModel *viewModel;

@end
