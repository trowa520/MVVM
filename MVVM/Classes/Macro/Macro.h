//
//  Macro.h
//  MVVM
//
//  Created by u on 2017/4/28.
//  Copyright © 2017年 zch. All rights reserved.
//

#ifndef Macro_h
#define Macro_h


//弱引用/强引用
#define LBWeakSelf(type) __weak typeof(type) weak##type = type;
// 懒加载
#define LB_LAZY(object, assignment) (object = object ?: assignment)
//屏幕宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#endif /* Macro_h */
