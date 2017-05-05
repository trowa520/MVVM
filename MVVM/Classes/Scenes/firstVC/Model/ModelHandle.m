//
//  ModelHandle.m
//  MVVM
//
//  Created by littleBit on 2017/5/5.
//  Copyright © 2017年 zch. All rights reserved.
//

#import "ModelHandle.h"
#import "CustomModel.h"

@interface ModelHandle ()

@property (nonatomic, strong) NSMutableArray *dataArrayList;

@end

@implementation ModelHandle

- (void)requestCustomDataWithHandleBlock:(ModelHandleBlock)handleBlcok {
    NSArray *array = @[@{@"name":@"小明",@"age":@"12"}];
    for (NSDictionary *dic in array) {
        CustomModel *model = [CustomModel new];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArrayList addObject:model];
    }
    handleBlcok(self.dataArrayList);
}
- (NSMutableArray *)dataArrayList {
    return LB_LAZY(_dataArrayList, @[].mutableCopy);
}
@end
