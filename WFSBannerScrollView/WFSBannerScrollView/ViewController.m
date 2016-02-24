//
//  ViewController.m
//  WFSBannerScrollView
//
//  Created by smc on 16/2/24.
//  Copyright © 2016年 smc. All rights reserved.
//

#import "ViewController.h"
#import "WHScrollAndPageView.h"
#import "CWDAutoScrollView.h"
#import "UIView+Layout.h"
#define NUM 10
#define VIEW_Width  [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<WHcrollViewViewDelegate,CWDAutoScrollViewDelegate>
{
 WHScrollAndPageView *_whView;
}
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    WFSBannerScrollView *scrollView = [[WFSBannerScrollView alloc] initWithFrame:CGRectMake(0, 100, VIEW_Width, VIEW_Width*3/4)];
//    autoScrollview.circledatasource= self;
//    autoScrollview.circledelegate = self;
//    [self.view addSubview:autoScrollview];
//    [self.view addSubview:scrollView];
    
    _whView = [[WHScrollAndPageView alloc] initWithFrame:CGRectMake(0, 300, VIEW_Width, 160)];
    
    //把N张图片放到imageview上
    NSMutableArray *tempAry = [NSMutableArray array];
    for (int i=1; i<NUM; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Sample%d.jpg",i+10]];
        [tempAry addObject:imageView];
    }
    
    //把imageView数组存到whView里
    [_whView setImageViewAry:tempAry];
    
    //把图片展示的view加到当前页面
    [self.view addSubview:_whView];
    
    //开启自动翻页
    [_whView shouldAutoShow:NO];
    
    //遵守协议
    _whView.delegate = self;
    
    
    //second
    NSArray *imageArray = @[
                            @"http://122.224.218.54:8081/group1/M00/39/1D/wKgD1FYm80CIG8JyAAAatyPMGu8892.jpg?w=640&h=260&c=0&p=0",
                            @"http://122.224.218.54:8081/group1/M00/BD/6B/wKgA1FQJdj3J4Y0mAAF-GAe3cto202.jpg?w=640&h=260&c=0&p=0",
                            @"http://122.224.218.54:8081/group1/M00/4F/3E/wKgA1FVkZi7DlUqAAAE1lipPstU540.jpg?w=640&h=260&c=0&p=0",
                            @"http://122.224.218.54:8081/group1/M00/F7/80/wKgA1FT9B8vZaQsHAADlMGmSYng033.jpg?w=640&h=260&c=0&p=0",
                            @"http://122.224.218.54:8081/group1/M00/2C/4B/wKgA1FTcFBacu_3BAAGrYUt5_1M242.png?w=640&h=260&c=0&p=0"
                            ];
    
    CWDAutoScrollView *autoScrollView = [[CWDAutoScrollView alloc] init];
    [autoScrollView updateViewWithImageArray:imageArray];
    autoScrollView.viewOriginY = 50;
    autoScrollView.infiniteScrolling = YES;
    [autoScrollView startAutoScrollWithInterval:3.0];
    autoScrollView.autoScrollDelegate = self;
    [self.view addSubview:autoScrollView];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.frame = CGRectMake(0, 0, autoScrollView.width, 10);
    self.pageControl.centerX = autoScrollView.centerX;
    self.pageControl.centerY = autoScrollView.bottom - 20;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.numberOfPages = imageArray.count;
    [self.view addSubview:self.pageControl];
}

#pragma mark 协议里面方法，点击某一页
-(void)didClickPage:(WHScrollAndPageView *)view atIndex:(NSInteger)index
{
    NSLog(@"点击了第%li页",index);
}

#pragma mark 界面消失的时候，停止自动滚动
-(void)viewDidDisappear:(BOOL)animated
{
    [_whView shouldAutoShow:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 第二种轮播
- (void)scrollImageClick:(NSInteger)index {
    [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"第%zd张图点击",index] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)updatePageControlNum:(NSInteger)index {
    self.pageControl.currentPage = index;
}


@end
