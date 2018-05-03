//
//  AnimationCircleView.m
//  dtcoretextdemo
//
//  Created by 李荣建 on 2018/5/3.
//  Copyright © 2018年 bool. All rights reserved.
//

#import "AnimationCircleView.h"
#import "UIView+WB.h"

#define kdurationTime 3.f
#define kradius 0.25*self.frame.size.width

#define circleWidth 5
@implementation AnimationCircleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    
}
-(void)dealloc{
    [self.timer invalidate];
}
-(void)stoken{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self  selector:@selector(makeSameTimeAnimation) userInfo:nil repeats:YES];

    CGFloat width = self.frame.size.height;
    UIBezierPath *circlepath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((self.frame.size.width - self.frame.size.height)/2, circleWidth/2, width-circleWidth, width-circleWidth)];
    CAShapeLayer *circleLayer = [CAShapeLayer new];
    circleLayer.fillColor = self.backColor.CGColor;
    circleLayer.lineWidth = circleWidth;
    circleLayer.strokeColor = [UIColor orangeColor].CGColor;
    circleLayer.path = circlepath.CGPath;
    [self.layer addSublayer:circleLayer];
    UIView *view = [UIView new];
    view.tag = 350;
    view.frame = CGRectMake(0, 0, self.frame.size.height-circleWidth*2, self.frame.size.height-circleWidth*2);
    view.centerX = self.centerX-circleWidth/2;
    view.y = circleWidth;
    view.alpha = 1;
    view.layer.cornerRadius = view.frame.size.height/2;
    
    view.backgroundColor = [UIColor blueColor];
    [self addSubview:view];
    
    [UIView animateWithDuration:0.8
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         view.transform = CGAffineTransformMakeScale(0.1, 0.1);
                         view.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         
                         
                         view.frame = CGRectMake(kradius*2-circleWidth/2, self.frame.size.height/2+circleWidth, 1, 1);
                         view.center = self.center;
                     }];
    [self makeSameTimeAnimation];
    [self makeSameTimeAnimation];


}
-(void)showEnd{
    [self.timer invalidate];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showafterEnd];
    });
}
-(void)showafterEnd{
    
    UIView *oldView = [self viewWithTag:350];
    [oldView removeFromSuperview];
    UIView *view = [UIView new];
    view.frame = CGRectMake(kradius*2-circleWidth/2, self.frame.size.height/2+circleWidth, 1, 1);
        view.center = self.center;
    view.layer.cornerRadius = 0.5;
    view.backgroundColor = [UIColor blueColor];
    [self addSubview:view];
    CGFloat scale = self.frame.size.height;

    [UIView animateWithDuration:0.8
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         view.transform = CGAffineTransformMakeScale(scale, scale);
                         view.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         view.frame = CGRectMake(0, 0, self.frame.size.height-circleWidth*2, self.frame.size.height-circleWidth*2);
                         view.centerX = self.centerX-circleWidth/2;
                         view.y = circleWidth;
                         view.alpha = 1;

                     }];
    
    
    CGFloat width = self.frame.size.height;

    UIBezierPath *circlepath = [UIBezierPath bezierPathWithArcCenter:self.center radius:kradius startAngle:0 endAngle:M_PI*2 clockwise:NO];

    CAShapeLayer *circleLayer1 = [CAShapeLayer new];
    circleLayer1.fillColor = [UIColor greenColor].CGColor;
    circleLayer1.lineWidth = 0;
    circleLayer1.strokeColor = [UIColor orangeColor].CGColor;
    circleLayer1.path = circlepath.CGPath;
    
    
    UIBezierPath *checkpath = [UIBezierPath bezierPath];
    [checkpath setLineWidth:10];
    //     起点
    [checkpath moveToPoint:CGPointMake(kradius*2-40, self.frame.size.height/2 - 10)];
    // 绘制线条
    [checkpath addLineToPoint:CGPointMake(kradius*2-10, self.frame.size.height/2+20)];
    [checkpath addLineToPoint:CGPointMake(kradius*2+40, self.frame.size.height/2 -30)];

    CAShapeLayer *circleLayer = [CAShapeLayer new];
    circleLayer.fillColor = nil;
    circleLayer.lineWidth = 10;
    circleLayer.strokeColor = [UIColor redColor].CGColor;
    circleLayer.path = checkpath.CGPath;
    circleLayer.lineCap = kCALineCapRound;
    circleLayer.lineJoin = kCALineJoinRound;

   
    CABasicAnimation * fillAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    fillAnimation.duration = 1;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fillAnimation.fillMode = kCAFillModeForwards;
    fillAnimation.removedOnCompletion = NO;
    fillAnimation.fromValue =  @(0.f);
    fillAnimation.toValue = @(1.f);
    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    animation.fromValue =  @(0.f);
//    animation.toValue = [NSNumber numberWithFloat:1.0f];
//    animation.duration = 1.0f;
   
    [circleLayer addAnimation:fillAnimation forKey:@"positionAnimation"];
//    [circleLayer1 addAnimation:animation forKey:nil];
    
//    [self.layer addSublayer:circleLayer1];
    [self.layer addSublayer:circleLayer];
    
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}
-(void)layoutViews{
   
    
}
-(void)makeSameTimeAnimation{

    NSInteger count = self.titleArr.count;
    int number = arc4random() % count;
    UILabel *label = [UILabel new];
    label.text = self.titleArr[number];
    label.frame = CGRectMake(0, 0, 80, 40);
    label.alpha = 0;
    [self addSubview:label];

    CFTimeInterval currentTime = CACurrentMediaTime();
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    int x = arc4random() % 6;
    
    UIBezierPath *path ;
    if (x%6==0) {
        path= [UIBezierPath bezierPathWithArcCenter:CGPointMake(kradius, self.frame.size.height/2) radius:kradius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    }
    if (x%6==1) {
        path= [UIBezierPath bezierPathWithArcCenter:CGPointMake(kradius+2*kradius, self.frame.size.height/2) radius:100 startAngle:-M_PI endAngle:M_PI clockwise:YES];
    }
    if (x%6==2) {
        path= [UIBezierPath bezierPathWithArcCenter:CGPointMake(kradius+2*kradius, self.frame.size.height/2) radius:100 startAngle:M_PI*3 endAngle:M_PI clockwise:NO];
    }
    if (x%6==3) {
        path= [UIBezierPath bezierPathWithArcCenter:CGPointMake(kradius, self.frame.size.height/2) radius:kradius startAngle:0 endAngle:M_PI*2 clockwise:NO];
    }
    if (x%6==4) {
        path = [UIBezierPath bezierPath];

        [path moveToPoint:CGPointMake(0, self.frame.size.height/2)];
        // 绘制线条
        [path addLineToPoint:CGPointMake(kradius*2, self.frame.size.height/2)];
    }
    if (x%6==5) {
        path = [UIBezierPath bezierPath];
        
        [path moveToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
        // 绘制线条
        [path addLineToPoint:CGPointMake(kradius*2, self.frame.size.height/2)];
    }
    animation.duration = kdurationTime;
    animation.path = path.CGPath;
    animation.beginTime = currentTime;
    [label.layer addAnimation:animation forKey:@"positionAnimation"];
    
    CABasicAnimation *scaleAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAni.fromValue = [NSNumber numberWithFloat:0.8f];
    scaleAni.toValue = [NSNumber numberWithFloat:2.5f];
    scaleAni.beginTime = currentTime;
    scaleAni.duration = kdurationTime/2;
    scaleAni.fillMode = kCAFillModeForwards;
    scaleAni.removedOnCompletion = NO;
    [label.layer addAnimation:scaleAni forKey:@"scaleAnimation"];
    
    CABasicAnimation *opacityanimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityanimation.fromValue = [NSNumber numberWithFloat:0.0f];
    opacityanimation.toValue = [NSNumber numberWithFloat:1.5f];
    opacityanimation.beginTime = currentTime;
    opacityanimation.duration = kdurationTime/2;
    [label.layer addAnimation:opacityanimation forKey:@"opacityAnimation"];
    
    CABasicAnimation *scaleAni1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAni1.fromValue = [NSNumber numberWithFloat:2.0f];
    scaleAni1.toValue = [NSNumber numberWithFloat:0.8f];
    scaleAni1.beginTime = currentTime +kdurationTime/2;
    scaleAni1.duration = kdurationTime/2;
    scaleAni1.fillMode = kCAFillModeForwards;
    scaleAni1.removedOnCompletion = NO;
    [label.layer addAnimation:scaleAni1 forKey:@"scaleAnimation1"];
    
    CABasicAnimation *opacityanimation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityanimation1.fromValue = [NSNumber numberWithFloat:1.0f];
    opacityanimation1.toValue = [NSNumber numberWithFloat:0.f];
    opacityanimation1.beginTime = currentTime +kdurationTime/2;
    opacityanimation1.duration = kdurationTime/2;
    [label.layer addAnimation:opacityanimation1 forKey:@"opacityAnimation"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kdurationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
    });

}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = self.backColor;
    //    CGFloat width = self.frame.size.height;
    //    UIBezierPath *circlepath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((self.frame.size.width - self.frame.size.height)/2, 0, width, width)];
    //    CAShapeLayer *circleLayer = [CAShapeLayer new];
    //    circleLayer.fillColor = self.backColor.CGColor;
    //    circleLayer.lineWidth = 10;
    //    circleLayer.strokeColor = [UIColor orangeColor].CGColor;
    //    circleLayer.path = circlepath.CGPath;
    //    [self.layer addSublayer:circleLayer];
}
@end
