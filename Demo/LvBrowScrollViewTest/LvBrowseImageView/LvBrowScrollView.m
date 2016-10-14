//
//  TWImageScrollView.m
//  PhotoShow
//
//  Created by lv on 16/9/9.
//  Copyright © 2016年 lv. All rights reserved.
//

#import "LvBrowScrollView.h"

@interface LvBrowScrollView ()<UIScrollViewDelegate>

@end

@implementation LvBrowScrollView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.alwaysBounceHorizontal = YES;
        self.alwaysBounceVertical = YES;
        self.bouncesZoom = YES;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.delegate = self;
        self.minimumZoomScale = 1.0f;
        self.maximumZoomScale = 2.0f;
    }
    return self;
}

- (void)displayImage:(UIImage *)image
{
    [self.imageView removeFromSuperview];
    self.imageView = nil;
    
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame = self.bounds;
    self.imageView.clipsToBounds = NO;
    self.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:self.imageView];
    

    CGSize contentSize = CGSizeZero;
    if (image.size.height > image.size.width)
    {
        contentSize=CGSizeMake(self.bounds.size.height*(image.size.width/image.size.height), self.bounds.size.height  );
    }
    else
    {
        contentSize=CGSizeMake(self.bounds.size.width, self.bounds.size.width  *(image.size.height/image.size.width));
    }
    
    
    self.contentSize = contentSize;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.m_delegate respondsToSelector:@selector(touchEnd)])
    {
        [self.m_delegate touchEnd];
    }
}

@end


