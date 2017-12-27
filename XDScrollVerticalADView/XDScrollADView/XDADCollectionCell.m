//
//  XDADCollectionCell.m
//  XDScrollVerticalADView
//
//  Created by Celia on 2017/12/26.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "XDADCollectionCell.h"

@interface XDADCollectionCell ()
@property (nonatomic, strong) UILabel *topTagTitle;     // 标签文字(上)
@property (nonatomic, strong) UILabel *topL;            // 广告文字(上)
@property (nonatomic, strong) UILabel *bottomTagTitle;  // 标签文字(下)
@property (nonatomic, strong) UILabel *bottomL;         // 广告文字(下)
@property (nonatomic, strong) UIImageView *rightIV;     // 右侧图片
@end

@implementation XDADCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createInterface];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setConstraints];
}

#pragma mark - 内部逻辑实现
#pragma mark - 代理协议
#pragma mark - 数据请求 / 数据处理
- (void)setModel:(ADCellModel *)model {
    _model = model;
    self.topTagTitle.text = model.topType;
    self.bottomTagTitle.text = model.bottomType;
    self.topL.text = model.topADTitle;
    self.bottomL.text = model.bottomADTitle;
    
    [self.rightIV setImage:[UIImage imageNamed:model.imageN]];
}

#pragma mark - 视图布局
- (void)createInterface {
    
    self.topTagTitle = [UILabel initLabelTextFont:12 textColor:[UIColor orangeColor] title:@"精品"];
    self.topTagTitle.layer.borderWidth = 0.5;
    self.topTagTitle.layer.borderColor = [UIColor orangeColor].CGColor;
    self.topTagTitle.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.topTagTitle];
    
    
    self.bottomTagTitle = [UILabel initLabelTextFont:12 textColor:[UIColor orangeColor] title:@"推荐"];
    self.bottomTagTitle.layer.borderWidth = 0.5;
    self.bottomTagTitle.layer.borderColor = [UIColor orangeColor].CGColor;
    self.bottomTagTitle.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.bottomTagTitle];
    
    
    self.topL = [UILabel initLabelTextFont:15 textColor:[UIColor darkGrayColor] title:@""];
    self.topL.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:self.topL];
    
    
    self.bottomL = [UILabel initLabelTextFont:15 textColor:[UIColor darkGrayColor] title:@""];
    self.bottomL.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:self.bottomL];
    
    
    self.rightIV = [[UIImageView alloc] init];
    self.rightIV.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.rightIV];
}

- (void)setConstraints {
    [self.topTagTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(6);
        make.top.equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(35, 18));
    }];
    
    [self.bottomTagTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topTagTitle);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(35, 18));
    }];
    
    [self.rightIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-5);
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(self.contentView.height);
    }];
    
    [self.topL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topTagTitle.mas_right).offset(4);
        make.right.equalTo(self.rightIV.mas_left).offset(-4);
        make.top.bottom.equalTo(self.topTagTitle);
    }];
    
    [self.bottomL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topL);
        make.top.bottom.equalTo(self.bottomTagTitle);
    }];
}

#pragma mark - 懒加载

@end
