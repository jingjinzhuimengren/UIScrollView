//
//  ViewController.m
//  Objective-C-UIScrollView
//
//  Created by WeiChaoW on 16/9/22.
//  Copyright © 2016年 WeiChaoW. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    
    //设置尺寸
    scrollView.frame = CGRectMake(0, 100, self.view.frame.size.width, 200);
    
    //设置背景色
    scrollView.backgroundColor = [UIColor redColor];
    
    //添加视图
    [self.view addSubview:scrollView];
    
    //设置滚动条
    //是否显示水平滚动条。
    scrollView.showsHorizontalScrollIndicator = YES;
    //是否显示竖直滚动条
    scrollView.showsVerticalScrollIndicator = NO;
    
    //设置分页滚动
    scrollView.pagingEnabled = YES;
    
    //设置是否可以拉出空白区域
    scrollView.bounces = YES;
    
    //default NO. if YES and bounces is YES, even if content is smaller than bounds, allow drag vertically
    //默认是NO。如果是YES并且bounces也是YES，即使内容尺寸比scrollView的尺寸小，也能垂直推动
    scrollView.alwaysBounceVertical = NO;
    
    // default NO. if YES and bounces is YES, even if content is smaller than bounds, allow drag horizontally
    //默认是NO。如果是YES并且bounces也是YES，即使内容尺寸比scrollView的尺寸小，也能水平推动
    scrollView.alwaysBounceHorizontal = NO;
    
    
    //允许滑动视图本身，如果设为NO就不能触发拖动代理事件
    scrollView.scrollEnabled = YES;
    
    //在scrollView的内容周围添加一个附件的区域
    scrollView.contentInset =  UIEdgeInsetsMake(100, 50, 50, 50);
    
    //调整指示器（滚动条）的位置
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(30, 30, 30, 30);
    
    //设置指示器（滚动条）的样式
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;//黑色
    
    //最小的缩放倍数，默认值为1.0
    scrollView.minimumZoomScale = 0.2;
    
    //放大的缩放倍数，默认值为1.0
    scrollView.maximumZoomScale = 100;
    
    //创建一个数组，存储三张图片
    NSArray *imagesArray = @[@"DOVE 2",@"DOVE 5",@"DOVE 10"];
    
    //循环创建ImageView
    for (NSInteger i = 0; i < imagesArray.count; i++) {
        
        //创建imageView
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        //添加图片
        imageView.image=[UIImage imageNamed:imagesArray[i]];
        //打开用户交互
        imageView.userInteractionEnabled = YES;
        //把imageView添加到滚动视图上
        [scrollView addSubview:imageView];
    }
    
    //设置内容区域
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*imagesArray.count,scrollView.frame.size.height);
    
    //设置代理
    scrollView.delegate = self;
    
    //设置directionalLockEnabled
    /*
     
     如果这个性能被设置成NO，scrollView会被允许在水平和垂直两个方向滚动。如果设置性能是YES并且用户开始在一个方向拖动时（水平方向或垂直方向），滚动视图就不能在另一个方向滚动。如果拖动的方向时斜对角线方向，拖动事件将会被锁住并且用户可以在任何方向拖动，直到拖动事件结束。这个属性的默认值是NO。
     */
    scrollView.directionalLockEnabled = YES;
    
    //设置偏移量，以固定的速度设置成新的偏移量
    [scrollView setContentOffset:CGPointMake(10, 20) animated:NO];
    
    //滚动矩形区域到可见的区域，如果完全可见就不做任何操作
    [scrollView scrollRectToVisible:CGRectMake(0, 0, 100, 300) animated:NO];
    
    //短时间显示滚动条，当你
    [scrollView flashScrollIndicators];
    
    //当用户触摸到scrollView时（即使还没有开始拖动ScrollView）就会返回一个YES值
    //    @property(nonatomic,readonly,getter=isTracking)     BOOL tracking;
    
    //当用户已经开始拖动时会返回一个YES值，这可能会需要一点时间或者与拖动一段距离
    //    @property(nonatomic,readonly,getter=isDragging)     BOOL dragging;
    
    //当用户不再拖动或者不再触摸scrollView(但是scrollView仍在滑动)
    //    @property(nonatomic,readonly,getter=isDecelerating) BOOL decelerating;
    
    //默认值为YES。如果为NO，会立即调用-touchesShouldBegin:withEvent:inContentView:方法，点击时没有任何反应。
    //    @property(nonatomic) BOOL delaysContentTouches;
    
    //默认值为YES。如果为NO,一旦我们开始追踪并且触摸移动，我们无法拖动
    //    @property(nonatomic) BOOL canCancelContentTouches;
    
    //默认返回YES。这个方法会在触摸手势被传递到scrollView的父View之前调用
    //    - (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event inContentView:(UIView *)view;
    
    //如果手势已经被传递到了scollView的父View上，在视图开始滚动之前毁掉用这个方法。如果这个方法返回的是NO，scrollView不会滚动并且这个手势会继续向父View传递
    //    - (BOOL)touchesShouldCancelInContentView:(UIView *)view;
    
    //设置缩放
    //    - (void)setZoomScale:(CGFloat)scale animated:(BOOL)animated
    //    - (void)zoomToRect:(CGRect)rect animated:(BOOL)animated
    
    
    //默认为YES。如果设置，当手势起作用时用户会经过最小／最大的区域，并且，在手势结束时这个区域会自动设置为最小／最大值。
    //    @property(nonatomic) BOOL  bouncesZoom;
    
    // 当用户向上的手势时，会返回YES
    //    @property(nonatomic,readonly,getter=isZooming)       BOOL zooming;
    
    NSLog(@"scrollView.zooming>>>>>%zd",scrollView.zooming);
    
    //当我们在最小和最大值中间的一个区域中，会返回YES。
    //    @property(nonatomic,readonly,getter=isZoomBouncing)  BOOL zoomBouncing;
    
    //滚动到顶部，默认值为YES
    //    @property(nonatomic) BOOL  scrollsToTop;
    
    
    // Use these accessors to configure the scroll view's built-in gesture recognizers.
    //使用这些容器配置scrollView内置的手势识别
    //    @property(nonatomic, readonly) UIPanGestureRecognizer *panGestureRecognizer NS_AVAILABLE_IOS(5_0);
    //    @property(nullable, nonatomic, readonly) UIPinchGestureRecognizer *pinchGestureRecognizer NS_AVAILABLE_IOS(5_0);
    //    @property(nonatomic, readonly) UIGestureRecognizer *directionalPressGestureRecognizer UIKIT_AVAILABLE_TVOS_ONLY(9_0);
    
    
    //创建UIPageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scrollView.frame.size.height-30,200, 30)];
    
    //总的图片页数
    pageControl.numberOfPages = 6;
    
    //当前页
    pageControl.currentPage = 0;
    
    //用户点击UIPageControl的响应函数
    [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    
    //设置pageControl 的尺寸
    CGSize size = [pageControl sizeForNumberOfPages:6];
    
}

//点点的点击事件
- (void)pageTurn:(UIPageControl *)pageControl{
    
    
}

//UIscrollView的协议代理方法
//滑动过程中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //    NSLog(@"滑动过程中");
}
//开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    //    NSLog(@"开始拖动");
    
}
//开始拖动（以某种速率和偏移量）
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    
}
//停止拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //    NSLog(@"停止拖动，开始滑动");
}
//开始滑动
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    //    NSLog(@"开始滑动");
    
}
//停止滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //    NSLog(@"停止滑动");
}



//允许缩放的视图(一个scrollview中只能有一个可以缩放且必须设置可以缩放的范围)
//-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//
//    //返回被缩放的试图
//    return imageView;
//}

//开始缩放的时候调用
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {
    
}

//正在缩放的时候调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    NSLog(@"qqqqqqqq");
    
}

//缩放完毕的时候调用
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
    
}

//将要滚动到顶部的时候调用
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollVie{
    
    return YES;
}

//滚动到顶部的时候调用
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
