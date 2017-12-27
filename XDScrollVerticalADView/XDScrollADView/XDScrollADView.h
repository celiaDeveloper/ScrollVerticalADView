//
//  XDScrollADView.h
//  XDScrollVerticalADView
//
//  Created by Celia on 2017/12/25.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XDScrollADView;
@protocol XDScrollADViewDelegate <NSObject>

- (void)XDScrollADView:(XDScrollADView *)scrollADView didSelectItemIndex:(NSInteger)index;

@end

@interface XDScrollADView : UIView

@property (nonatomic, weak) id <XDScrollADViewDelegate>delegate;

/** 滚动时间间隔(默认 3s) */
@property (nonatomic, assign) CGFloat scrollTimeInterval;

/** 数据模型数组 */
@property (nonatomic, strong) NSArray *dataArray;

/** 左侧图片名称 */
@property (nonatomic, copy) NSString *leftImageName;

@end
