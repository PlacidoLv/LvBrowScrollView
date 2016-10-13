//
//  LvImageShowView.h
//  PhotoShow
//
//  Created by lv on 16/9/9.
//  Copyright © 2016年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LvBrowseImageView;

@protocol LvBrowseImageViewDelegate <NSObject>

@optional

//浏览时左右切换图片时 告知当前显示的图片相对屏幕的frame
-(CGRect )scrollViewDidEndDecelerating:(UIScrollView *)scrollView page:(NSInteger)page showView:(LvBrowseImageView *)browseImageView;

@end


@interface LvBrowseImageView : UIView

@property(nonatomic,assign)NSInteger currentPage;//选中的图片序号
@property(nonatomic,assign)CGRect rectFather;//选中的图片相对于屏幕的frame
@property(nonatomic,assign)id<LvBrowseImageViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame imgs:(NSArray *)arrImgs;
-(void)showInView:(UIView *)view;
@end
