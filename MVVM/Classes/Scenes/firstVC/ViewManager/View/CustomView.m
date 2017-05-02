//
//  CustomView.m
//  MVVM
//
//  Created by u on 2017/4/28.
//  Copyright © 2017年 zch. All rights reserved.
//

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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
