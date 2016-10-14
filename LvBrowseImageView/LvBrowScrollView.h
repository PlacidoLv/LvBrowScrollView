//
//  TWImageScrollView.h
//  PhotoShow
//
//  Created by lv on 16/9/9.
//  Copyright © 2016年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageScrollViewDelegate <NSObject>

@optional

-(void)touchEnd;

@end

@interface LvBrowScrollView : UIScrollView

- (void)displayImage:(UIImage *)image;

@property (strong, nonatomic) UIImageView *imageView;
@property(nonatomic,assign)id<ImageScrollViewDelegate>m_delegate;

@end


