//
//  ViewManager.h
//  MVVM
//
//  Created by u on 2017/4/28.
//  Copyright © 2017年 zch. All rights reserved.
//

//用来控制该显示的页面及处理页面效果


#import <Foundation/Foundation.h>
@class CustomView;



typedef  void(^setCustomViewBlock)(NSArray *array);


@interface ViewManager : NSObject

@property (nonatomic,copy)setCustomViewBlock setViewBlock;

@property (nonatomic,weak)CustomView *customView;

- (void)managerBtnBlockWithView:(UIView *)supView;

@end
