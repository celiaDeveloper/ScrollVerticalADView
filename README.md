# XDScrollVerticalADView


仿淘宝首页   淘宝头条垂直滚动的广告

Demo中Model可根据实际应用中的数据进行更改
cell根据需要自行修改

代码的关键部分是定时器执行的代码
```
- (void)beginUpdateUI {
if (self.dataArray.count == 0) return;

// 1.当前正在展示的位置
NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];

// 共100个分组(每个分组数据相同)  都次都展示第50分组数据 当滚动到51分组 此处就把它变回50分组
NSIndexPath *resetCurrentIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0.5 * scrollADViewMaxSections];
[self.collectionView scrollToItemAtIndexPath:resetCurrentIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];

// 2.计算出下一个需要展示的位置
NSInteger nextItem = resetCurrentIndexPath.item + 1;
NSInteger nextSection = resetCurrentIndexPath.section;
if (nextItem == self.dataArray.count) {
nextItem = 0;
nextSection++;
}

NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
// 3.通过动画滚动到下一个位置
[self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}
```

参考了：SGAdvertScrollView
