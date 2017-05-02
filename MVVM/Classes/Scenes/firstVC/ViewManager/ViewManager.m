//
//  ViewManager.m
//  MVVM
//
//  Created by u on 2017/4/28.
//  Copyright © 2017年 zch. All rights reserved.
//

#import "ViewManager.h"
#import "CustomView.h"


@interface ViewManager ()


@end


@implementation ViewManager

- (void)managerBtnBlockWithView:(UIView *)supView{
    LBWeakSelf(self)
    [supView addSubview:self.customView];
    weakself.customView.btnActBlock = ^(UIButton *sender) {
        NSLog(@"%@",sender.currentTitle);
    };
    
    weakself.setViewBlock = ^(NSArray *array) {
        weakself.customView.setVBlock(array);
    };
}
- (CustomView *)customView {
    return LB_LAZY(_customView, ({
        CustomView *cV = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:nil options:nil].firstObject;
        cV;
    }));
}
@end
