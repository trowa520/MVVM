//
//  ModelHandle.h
//  MVVM
//
//  Created by littleBit on 2017/5/5.
//  Copyright © 2017年 zch. All rights reserved.
//


/**
 * 处理数据，将数据转化为模型 -->  提供给viewModel
 *
 */
#import <Foundation/Foundation.h>

typedef void(^ModelHandleBlock)(NSArray *array);

@interface ModelHandle : NSObject
//请求数据
- (void)requestCustomDataWithHandleBlock:(ModelHandleBlock)handleBlcok;

@end
