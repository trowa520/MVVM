# MVVM
自己定制到MVVM，没用任何第三方
###网上关于MVVM的介绍太多，我不再啰嗦了，直接上干货。
####ps：没使用任何第三方，适合刚接触MVVM的同学拿来参考，如果您已是高手，希望您能提出宝贵意见。谢谢

*架构还是有必要了解一下的*

![MVVM架构图解.png](http://upload-images.jianshu.io/upload_images/1009301-b4d9c6b01689f6d9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![项目结构目录.png](http://upload-images.jianshu.io/upload_images/1009301-ab4b60f9bf683772.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

都知道目录是这样，里面代码逻辑怎么实现呢？详见页底demo传送门
#1、Controller 负责 ViewManager 与 ViewModel 之间的绑定
在这里你只需`import`两个文件`ViewManger`，`CustomViewModel`
###.m 全部代码
```bash
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
    //实现viewModel 与 View 的绑定
    [self.viewModel fetchRequestCustomDataWithModelArray:^(NSMutableArray *array){
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

```
#2、ViewModel 处理业务逻辑  
###.h文件
```bash
#import <Foundation/Foundation.h>

typedef void(^modelArrayBlock) (NSMutableArray *array);

@interface CustomViewModel : NSObject

- (void)fetchRequestCustomDataWithModelArray:(modelArrayBlock)arrayBlock;

@end
```
###.m文件
 ```bash
@implementation CustomViewModel

- (void)fetchRequestCustomDataWithModelArray:(modelArrayBlock)arrayBlock{
    [[ModelHandle new]requestCustomDataWithHandleBlock:^(NSArray *array) {
        arrayBlock((NSMutableArray *)array);
    }];
}
@end

```
#3、ModelHandle 用来处理网络请求，转化为模型数据，与ViewModel，Model交互，实现ViewModel 与 Model 解耦
###.h文件
```bash
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
```

###.m文件
```bash
#import "ModelHandle.h"
#import "CustomModel.h"

@interface ModelHandle ()

@property (nonatomic, strong) NSMutableArray *dataArrayList;

@end

@implementation ModelHandle
//    模拟网络请求
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
```
#4、ViewManager 用来处理View的常规事件，负责管理View
###.h 文件
```bash
#import <Foundation/Foundation.h>
@class CustomView;

typedef  void(^setCustomViewBlock)(NSArray *array);

@interface ViewManager : NSObject

@property (nonatomic,copy)setCustomViewBlock setViewBlock;

@property (nonatomic,weak)CustomView *customView;

- (void)managerBtnBlockWithView:(UIView *)supView;
@end
```
###.m文件
```bash
#import "ViewManager.h"
#import "CustomView.h"

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
```
#5、View 用来呈现用户界面
###.h 文件
```bash
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
```
###.m 文件
```bash
#import "CustomView.h"
#import "CustomModel.h"
@interface CustomView ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;


@end

@implementation CustomView
- (IBAction)firstBtnAction:(UIButton *)sender {
    self.btnActBlock(sender);
}

- (IBAction)sectionBtnAction:(UIButton *)sender {
    self.btnActBlock(sender);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    LBWeakSelf(self)
    self.setVBlock = ^(NSArray *array) {
        CustomModel *model = array.firstObject;
        weakself.nameLabel.text = model.name;
        weakself.ageLabel.text = model.age;
    };
}
@end
```

#6、Model  用来呈现数据
###.h 文件
```bash
#import <Foundation/Foundation.h>

@interface CustomModel : NSObject
//客户编号
@property(copy,nonatomic)NSString *name;
//客户名称
@property(copy,nonatomic)NSString *age;

@end
```
[demo传送门](https://github.com/LittleBitCode/MVVM.git)
