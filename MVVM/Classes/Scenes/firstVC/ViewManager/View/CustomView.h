//
//  CustomView.h
//  MVVM
//
//  Created by u on 2017/4/28.
//  Copyright © 2017年 zch. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  view的事件 全部交由viewManager 处理
 */
typedef void (^btnIsClicked)(UIButton *sender);
typedef void (^setViews)(NSArray *array);


@interface CustomView : UIView

@property (nonatomic,copy)btnIsClicked btnActBlock;

@property (nonatomic,copy)setViews setVBlock;

@end
