//
//  MVVM_RACViewController.m
//  PNATDemo
//
//  Created by 张泉 on 15/9/15.
//  Copyright © 2015年 张泉. All rights reserved.
//

#import "MVVM_RACViewController.h"
#import "ReactiveCocoa.h"
#import "PhoneNumberAttributionViewModel.h"

@interface MVVMViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumInputTextField;
@property (weak, nonatomic) IBOutlet UIButton *queryButton;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *carrierLabel;
@property (weak, nonatomic) IBOutlet UILabel *simSuitLabel;
@property (weak, nonatomic) IBOutlet UILabel *queryStatusLabel;


@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.viewModel = [[PhoneNumberAttributionViewModel alloc] init];
    
    [self addKVO];
    [self configRAC];
    
}

- (void)dealloc {
    [self removeKVO];
}

#pragma mark - KVO

- (void)addKVO {
    [self.viewModel addObserver:self forKeyPath:@"queryStatusString" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)removeKVO {
    [self.viewModel removeObserver:self forKeyPath:@"queryStatusString"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (object == self.viewModel && [keyPath isEqualToString:@"queryStatusString"]) {
        NSString *value = [change valueForKey:NSKeyValueChangeNewKey];
        self.queryStatusLabel.text = value;
    }

}

#pragma mark - RAC

- (void)configRAC {
    RAC(self.queryButton, enabled) = RACObserve(self.viewModel, phoneNumberValid);
    
    RACSignal *phoneNumberInputTextSignal = [self.phoneNumInputTextField rac_textSignal];
    RAC(self.viewModel, phoneNumberString) = [phoneNumberInputTextSignal filter:^BOOL(id value) {
        return ((NSString *)value).length <= 11;
    }];
    
    RAC(self.phoneNumberLabel, text) = RACObserve(self.viewModel, phoneNumberString);
    RAC(self.provinceLabel, text) = RACObserve(self.viewModel, provinceString);
    RAC(self.cityLabel, text) = RACObserve(self.viewModel, cityString);
    RAC(self.carrierLabel, text) = RACObserve(self.viewModel, carrierString);
    RAC(self.simSuitLabel, text) = RACObserve(self.viewModel, simSuitString);
    
    @weakify(self);
    [[self.queryButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel queryPhoneNumberAttribution];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
