//
//  LvImageShowView.m
//  PhotoShow
//
//  Created by lv on 16/9/9.
//  Copyright © 2016年 lv. All rights reserved.
//

#import "LvBrowseImageView.h"
#import "LvBrowScrollView.h"
#import "UIImageView+WebCache.h"
@interface LvBrowseImageView ()<UIScrollViewDelegate,ImageScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSMutableArray *_arrBrowseImage;
    UIImageView *_currentImg;
    LvBrowScrollView *_currentScrollView;
}
@end


@implementation LvBrowseImageView



- (instancetype)initWithFrame:(CGRect)frame imgs:(NSArray *)arrImgs
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor blackColor];
        _arrBrowseImage=[NSMutableArray arrayWithCapacity:0];
        [_arrBrowseImage addObjectsFromArray:arrImgs];
        
    }
    return self;
}

-(void)showInView:(UIView *)view
{
    self.alpha=0;
    [view addSubview:self];
     [self scrollViewLoad];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=1;
    }];
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _currentImg.frame=CGRectMake(self.frame.size.width*self.currentPage, 0, self.frame.size.width, self.frame.size.height);
        _currentScrollView.imageView.bounds=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _currentScrollView.imageView.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);

    } completion:nil];
    
    
}

-(void)tapExitClick
{
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha=0;
        _currentScrollView.zoomScale=1;
        _currentScrollView.imageView.frame=self.rectFather ;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _currentPage=scrollView.contentOffset.x/self.frame.size.width;
    _pageControl.currentPage=_currentPage;
    _currentScrollView=[scrollView viewWithTag:166000+_currentPage];
    
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:page:showView:)])
    {
        self.rectFather=  [self.delegate scrollViewDidEndDecelerating:scrollView page:_currentPage showView:self];
    }
}

-(void)scrollViewLoad
{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_arrBrowseImage enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*idx, 0, self.frame.size.width, self.frame.size.height)];
        [img sd_setImageWithURL:[NSURL URLWithString:obj] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image)
            {
                CGRect rect=CGRectMake(self.frame.size.width*idx, 0, self.frame.size.width, self.frame.size.height);
                
                LvBrowScrollView *_imageScrollView = [[LvBrowScrollView alloc] initWithFrame:rect];
                [_imageScrollView displayImage:image];
                _imageScrollView.clipsToBounds=YES;
                _imageScrollView.m_delegate=self;
                _imageScrollView.tag=166000+idx;
                [_scrollView addSubview:_imageScrollView];
                
                if (_currentPage==idx)
                {
                    _currentImg=img;
                    img.frame=self.rectFather;
                    _currentScrollView=_imageScrollView;
                    _currentScrollView.imageView.frame=self.rectFather;
                }
                
                img.image=nil;
            }
        }];
        
        
        img.contentMode=UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:img];
        
        
    }];
    
    _scrollView.contentSize=CGSizeMake(_arrBrowseImage.count*self.frame.size.width,self.frame.size.height);
    _scrollView.contentOffset=CGPointMake(self.frame.size.width*self.currentPage, 0);
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    [self addSubview:_scrollView];
    
    [_pageControl removeFromSuperview];
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 60, self.frame.size.width, 30)];
    _pageControl.numberOfPages = _arrBrowseImage.count;
    _pageControl.currentPage = self.currentPage;
    
    
    
    [self addSubview:_pageControl];
    
    _scrollView.contentOffset=CGPointMake(self.frame.size.width*self.currentPage, 0);
}


-(void)touchEnd
{
     [self tapExitClick];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self tapExitClick];
}

@end
