//
//  CustomViewModel.m
//  MVVM
//
//  Created by u on 2017/4/28.
//  Copyright © 2017年 zch. All rights reserved.
//

#import "CustomViewModel.h"
#import "CustomModel.h"
@interface CustomViewModel ()
@property (nonatomic, strong) NSMutableArray *dataArrayList;
@end

@implementation CustomViewModel

- (void)fetchRequestCustomDataWithModelArray:(modelArrayBlock)arrayBlock{
    NSArray *array = @[@{@"name":@"小明",@"age":@"12"}];
    for (NSDictionary *dic in array) {
        CustomModel *model = [CustomModel new];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArrayList addObject:model];
    }
    arrayBlock(self.dataArrayList);
}



- (NSMutableArray *)dataArrayList {
    return LB_LAZY(_dataArrayList, @[].mutableCopy);
}

@end
