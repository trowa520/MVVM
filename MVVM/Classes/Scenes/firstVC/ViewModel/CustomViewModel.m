//
//  CustomViewModel.m
//  MVVM
//
//  Created by u on 2017/4/28.
//  Copyright © 2017年 zch. All rights reserved.
//

#import "CustomViewModel.h"
#import "ModelHandle.h"
@interface CustomViewModel ()
@property (nonatomic, strong) NSMutableArray *dataArrayList;
@end

@implementation CustomViewModel

- (void)fetchRequestCustomDataWithModelArray:(modelArrayBlock)arrayBlock{
    [[ModelHandle new]requestCustomDataWithHandleBlock:^(NSArray *array) {
        arrayBlock((NSMutableArray *)array);
    }];
    
}


- (NSMutableArray *)dataArrayList {
    return LB_LAZY(_dataArrayList, @[].mutableCopy);
}

@end
