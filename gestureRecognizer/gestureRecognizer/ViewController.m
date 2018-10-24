//
//  ViewController.m
//  gestureRecognizer
//
//  Created by MAC on 2018/10/23.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGPoint startPoint;
    CGPoint originPoint;
    CGFloat lastScale;
}

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //定义一个按钮
    UIView * view = [UIButton buttonWithType:UIButtonTypeCustom];
    view.frame = CGRectMake(100, 100, 100, 100);
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
//    [self createSwipeGesture:view];//轻扫
//    [self createTapGesture:view];//点按
//    [self createLongGesture:view];//长按 (可以实现长按拖拽 和Pan的响应方法相同即可)
//    [self createPanGesture:view];//拖拽
    [self createRotationGesture:view];//旋转
//    [self createPinchGesture:view];//捏合
}

//轻扫
- (void)createSwipeGesture:(UIView *)view {
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    //轻扫手指的数量
    swipe.numberOfTouchesRequired = 1;
    //轻扫的方向默认UISwipeGestureRecognizerDirectionRight
//    swipe.direction = UISwipeGestureRecognizerDirectionRight;//向右
//    swipe.direction = UISwipeGestureRecognizerDirectionUp;//向上
//    swipe.direction = UISwipeGestureRecognizerDirectionLeft;//向左
    swipe.direction = UISwipeGestureRecognizerDirectionDown;//向下
    [view addGestureRecognizer:swipe];
}

- (void)swipeGesture:(UIGestureRecognizer *)swipe {
    UISwipeGestureRecognizer * gesture = (UISwipeGestureRecognizer *)swipe;
    if (gesture.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"向上轻扫");
    } else if (gesture.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"向下轻扫");
    } else if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"向左轻扫");
    } else {
        NSLog(@"向右轻扫");
    }
}

//点按
- (void)createTapGesture:(UIView *)view {
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 2;//双击
    [view addGestureRecognizer:tap];
}

- (void)tapGesture:(UIGestureRecognizer *)tap {
    UITapGestureRecognizer * gesture = (UITapGestureRecognizer *)tap;
    NSLog(@"点击了%lu次触发",(unsigned long)gesture.numberOfTapsRequired);
}

//拖动
- (void)createPanGesture:(UIView *)view {
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureEvent:)];
    [view addGestureRecognizer:pan];
}


//长按
- (void)createLongGesture:(UIView *)view {
    UILongPressGestureRecognizer * longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesture:)];
    longGesture.numberOfTapsRequired = 0;//长点击响应前点击次数,默认0；
    longGesture.numberOfTouchesRequired = 1;// 用户触摸的手指数，默认1
    longGesture.minimumPressDuration = 0.5;//长按最低时间，默认0.5秒
    longGesture.allowableMovement = 5;//手指长按期间可移动的区域，默认10像素
    [view addGestureRecognizer:longGesture];
}

- (void)longGesture:(UILongPressGestureRecognizer *)longGesture {
    if (longGesture.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"开始");
    }
    else if (longGesture.state == UIGestureRecognizerStateChanged)
    {
        NSLog(@"进行中");
    }
    else if (longGesture.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"结束");
    }
}

//旋转
- (void)createRotationGesture:(UIView *)view {
    UIRotationGestureRecognizer * rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGesture:)];
    [view addGestureRecognizer:rotationGesture];
}

- (void)rotationGesture :(UIRotationGestureRecognizer *) rotationGesture{
    //捏合手势两种改变方式
    //以原来的位置为标准
//    rotationGesture.view.transform = CGAffineTransformMakeRotation(rotationGesture.rotation);//rotation 是旋转角度
    //两个参数,以上位置为标准
    rotationGesture.view.transform = CGAffineTransformRotate(rotationGesture.view.transform, rotationGesture.rotation);
    //消除增量
    rotationGesture.rotation = 0.0;
}

//捏合
- (void)createPinchGesture:(UIView *)view {
    //缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handlePinch:)];
    
    [view addGestureRecognizer:pinchGestureRecognizer];
}
    
  

-(void)handlePinch:(UIPinchGestureRecognizer *)sender
{
    //scale 缩放比例
    //    sender.view.transform = CGAffineTransformMake(sender.scale, 0, 0, sender.scale, 0, 0);
    //每次缩放以原来位置为标准
    //    sender.view.transform = CGAffineTransformMakeScale(sender.scale, sender.scale);
    
    //每次缩放以上一次为标准
    sender.view.transform = CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale);
    //重新设置缩放比例 1是正常缩放.小于1时是缩小(无论何种操作都是缩小),大于1时是放大(无论何种操作都是放大)
    sender.scale = 1;

}

//拖动
- (void)gestureEvent:(UIGestureRecognizer *)sender {
    UIView *btn = (UIView *)sender.view;
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        startPoint = [sender locationInView:sender.view];
        originPoint = btn.center;
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint newPoint = [sender locationInView:sender.view];
        CGFloat deltaX = newPoint.x-startPoint.x;
        CGFloat deltaY = newPoint.y-startPoint.y;
        btn.center = CGPointMake(btn.center.x+deltaX,btn.center.y+deltaY);
        [UIView animateWithDuration:1 animations:^{
            CGPoint temp = CGPointZero;
            temp = btn.center;
            btn.center = temp;
            originPoint = btn.center;
        }];
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:1 animations:^{
            if (originPoint.x - btn.frame.size.width/2<=0) {
                originPoint.x = btn.frame.size.width/2 + 10;
            }
            if (originPoint.y  - btn.frame.size.height/2 - 20 <=0) {
                originPoint.y = btn.frame.size.height/2 + 44 + 10;
            }
            if (originPoint.x >= [UIScreen mainScreen].bounds.size.width- btn.frame.size.width/2) {
                originPoint.x = [UIScreen mainScreen].bounds.size.width - btn.frame.size.width/2 - 10;
            }
            if (originPoint.y >= [UIScreen mainScreen].bounds.size.height- btn.frame.size.height/2) {
                originPoint.y = [UIScreen mainScreen].bounds.size.height- btn.frame.size.height/2 - 10;
            }
            btn.center = originPoint;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
