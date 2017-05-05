//
//  FirstVC.m
//  MVVM
//
//  Created by u on 2017/4/28.
//  Copyright © 2017年 zch. All rights reserved.
//

#import "FirstVC.h"
#import "ViewManager.h"
#import "CustomViewModel.h"
@interface FirstVC ()
@property(nonatomic,strong)ViewManager *viewManager;
@property(nonatomic,strong)CustomViewModel *viewModel;

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //让View的点击事件交给viewManager
    [self.viewManager managerBtnBlockWithView:self.view];
    //ViewModel 获取数据
    [self.viewModel fetchRequestCustomDataWithModelArray:^(NSMutableArray *array) {
        self.viewManager.setViewBlock(array);
    }];
}

- (ViewManager *)viewManager {
   return  LB_LAZY(_viewManager, ({
        ViewManager *manager = [ViewManager new];
        manager;
    }));
}
- (CustomViewModel *)viewModel {
    return LB_LAZY(_viewModel, ({
        CustomViewModel *cVM = [CustomViewModel new];
        cVM;
    }));
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
