//
//  XDScrollADView.m
//  XDScrollVerticalADView
//
//  Created by Celia on 2017/12/25.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "XDScrollADView.h"
#import "XDADCollectionCell.h"

static NSString *const cellIDADCollection = @"XDADCollectionCell";

static NSUInteger const scrollADViewMaxSections = 100;

@interface XDScrollADView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UIImageView *leftIV;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation XDScrollADView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initialization];
        [self createInterface];
    }
    return self;
}

- (void)initialization {
    _scrollTimeInterval = 3.0;
    [self addTimer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置初始展示的item
    if (self.dataArray.count == 0) return;
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0.5 * scrollADViewMaxSections] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
}

#pragma mark - 内部逻辑实现
- (void)addTimer {
    [self removeTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollTimeInterval target:self selector:@selector(beginUpdateUI) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)beginUpdateUI {
    if (self.dataArray.count == 0) return;
    
    // 1、当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    // 共100个分组(每个分组数据相同)  都次都展示第50分组数据 当滚动到51分组 此处就把它变回50分组
    NSIndexPath *resetCurrentIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0.5 * scrollADViewMaxSections];
    [self.collectionView scrollToItemAtIndexPath:resetCurrentIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    
    // 2、计算出下一个需要展示的位置
    NSInteger nextItem = resetCurrentIndexPath.item + 1;
    NSInteger nextSection = resetCurrentIndexPath.section;
    if (nextItem == self.dataArray.count) {
        nextItem = 0;
        nextSection++;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    // 3、通过动画滚动到下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}

#pragma mark - 代理协议
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return scrollADViewMaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XDADCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIDADCollection forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

#pragma mark - 数据请求 / 数据处理
- (void)setScrollTimeInterval:(CGFloat)scrollTimeInterval {
    _scrollTimeInterval = scrollTimeInterval;
    if (scrollTimeInterval) {
        [self addTimer];
    }
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    if (dataArray.count <= 1 ) {
        [self removeTimer];
    }
    [self.collectionView reloadData];
}

- (void)setLeftImageName:(NSString *)leftImageName {
    _leftImageName = leftImageName;
    [_leftIV setImage:[UIImage imageNamed:leftImageName]];
}

#pragma mark - 视图布局
- (void)createInterface {
    // 最左侧图片
    self.leftIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.height, self.height)];
    self.leftIV.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.leftIV];
    
    // collectionView
    [self addSubview:self.collectionView];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        CGFloat itemW = self.width - self.leftIV.width;
        
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(itemW, self.height);
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(_leftIV.right, 0, itemW, self.height) collectionViewLayout:_flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[XDADCollectionCell class] forCellWithReuseIdentifier:cellIDADCollection];
    }
    return _collectionView;
}

@end
