//
//  CustomViewModel.h
//  MVVM
//
//  Created by u on 2017/4/28.
//  Copyright © 2017年 zch. All rights reserved.
#warning 不要引入任何视图

/**
 *  提供数据
 *  处理业务逻辑
 */
#import <Foundation/Foundation.h>
typedef void (^setViews)(NSArray *array);

typedef void(^modelArrayBlock) (NSMutableArray *array);

@interface CustomViewModel : NSObject

- (void)fetchRequestCustomDataWithModelArray:(modelArrayBlock)arrayBlock;

@property (nonatomic,copy)setViews setVBlock;
@end
