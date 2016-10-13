//
//  ViewController.m
//  LvBrowScrollView
//
//  Created by lv on 2016/10/10.
//  Copyright © 2016年 lv. All rights reserved.
//

#import "ViewController.h"
#import "LvBrowseImageView.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()<LvBrowseImageViewDelegate,UIScrollViewDelegate>
{
    NSArray *_arrImages;
    UIScrollView *_scrollView;
    CGFloat _floatScrollOffSetX;
    NSInteger _intSelectCount;
}
@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _arrImages=@[@"http://img1.voc.com.cn/UpLoadFile/2016/09/08/201609080838264107.jpg",
                 @"http://scimg.jb51.net/allimg/160815/103-160Q509544OC.jpg",
                 @"http://www.pptbz.com/pptpic/uploadfiles_6909/201202/2012022917310499.jpg",
                 @"http://img1.3lian.com/img013/v3/56/d/101.jpg",
                 @"http://img.taopic.com/uploads/allimg/120423/95347-1204232000449.jpg",
                 @"http://uploads.yjbys.com/allimg/201609/3958-1609101IJ4462.jpg"];
    
    UILabel *labShow1=[[UILabel alloc]initWithFrame:CGRectMake(15, 70, 100, 20)];
    labShow1.text=@"矩阵排列";
    labShow1.textColor=[UIColor blackColor];
    [self.view addSubview:labShow1];
    
    [_arrImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *imgFrame=[[UIImageView alloc]initWithFrame:CGRectMake(40+100*(idx%3), 100+100*(idx/3), 80, 80)];
        [imgFrame sd_setImageWithURL:[NSURL URLWithString:obj]];
        imgFrame.userInteractionEnabled=YES;
        imgFrame.tag=12000+idx;
        [self.view addSubview:imgFrame];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [imgFrame addGestureRecognizer:tap];
    }];
    
    
    UILabel *labShow2=[[UILabel alloc]initWithFrame:CGRectMake(15, 320, 100, 20)];
    labShow2.text=@"横排";
    labShow2.textColor=[UIColor blackColor];
    [self.view addSubview:labShow2];
    
    [self.view addSubview:[self scrollViewLoad]];
}

-(UIScrollView *)scrollViewLoad
{
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 100)];
    __block CGFloat floatW=100;
    
    [_arrImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj&&![obj isEqualToString:@""]) {
            
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(20+floatW*idx, 5, 80, 80)];
            img.userInteractionEnabled=YES;
            img.contentMode=UIViewContentModeScaleAspectFill;
            img.clipsToBounds=YES;
            img.tag=13000+idx;
            [img sd_setImageWithURL:[NSURL URLWithString:obj] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            [_scrollView addSubview:img];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
            [img addGestureRecognizer:tap];
        }
        
    }];
    
    _scrollView.clipsToBounds=YES;
    _scrollView.delegate=self;
    _scrollView.contentSize=CGSizeMake(floatW*_arrImages.count+40, 100);
    return _scrollView;
}

-(void)tapClick:(UITapGestureRecognizer *)tap
{
    //横排时
    if (tap.view.tag>=13000)
    {
        LvBrowseImageView *imgShow=[[LvBrowseImageView alloc]initWithFrame:self.view.bounds imgs:_arrImages];
        imgShow.rectFather=[_scrollView convertRect:tap.view.frame toView:self.view];
        imgShow.currentPage=tap.view.tag-13000;
        imgShow.delegate=self;
        imgShow.tag=101;
        [imgShow showInView:self.view];
        _intSelectCount=imgShow.currentPage;
    }
    else//矩阵排列时
    {
        LvBrowseImageView *imgShow=[[LvBrowseImageView alloc]initWithFrame:self.view.bounds imgs:_arrImages];
        imgShow.rectFather=tap.view.frame;
        imgShow.currentPage=tap.view.tag-12000;
        imgShow.delegate=self;
        imgShow.tag=100;
        [imgShow showInView:self.view];
        
        
    }
}


#pragma mark LvBrowseImageViewDelegate
-(CGRect)scrollViewDidEndDecelerating:(UIScrollView *)scrollView page:(NSInteger)page showView:(LvBrowseImageView *)browseImageView
{
    if (browseImageView.tag==101)
    {
        CGFloat floatX=_floatScrollOffSetX+100*(page-_intSelectCount);
        
        //浏览时左右滑动图片时，_scrollView也跟着滑动，滑动的范围 0-contentSize.width 超过此范围则不滑动
        if (floatX<_scrollView.contentSize.width)
        {
            _scrollView.contentOffset=CGPointMake(floatX<0?0:floatX, 0);
        }
        
        CGFloat floatContentOffSetX=(40+_arrImages.count*100)-self.view.frame.size.width;
        if (_scrollView.contentOffset.x>floatContentOffSetX)
        {
            _scrollView.contentOffset=CGPointMake(floatContentOffSetX, 0);
        }
        
        //返回当前浏览的图片相对于屏幕的frame
        UIImageView *img=[_scrollView  viewWithTag:13000+page];
        
        return [_scrollView convertRect:img.frame toView:self.view];
    }
    else
    {
        //返回当前浏览的图片相对于屏幕的frame
        return CGRectMake(40+100*(page%3), 100+100*(page/3), 80, 80);
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==_scrollView)
    {
        _floatScrollOffSetX=scrollView.contentOffset.x;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

