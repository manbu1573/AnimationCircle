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
@interface AnimationCircleView ()
@property (nonatomic,strong) CAShapeLayer *circle1;
@property (nonatomic,strong) CAShapeLayer *circle2;
@property (nonatomic,strong) CAShapeLayer *circle3;


@end
@implementation AnimationCircleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.




- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = self.backColor;

    
}
-(void)stoken{
    [self drawCircles];

    [self makeSameTimeAnimation];
    [self makeSameTimeAnimation];
    CGFloat width = self.frame.size.height;
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self  selector:@selector(makeSameTimeAnimation) userInfo:nil repeats:YES];
    
    self.circle1 = [self shapeLayerWithFromRadius:width/2+3 WithToRadius:width/2+20];
    
    [self.layer addSublayer:self.circle1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.circle2 = [self shapeLayerWithFromRadius:width/2+3 WithToRadius:width/2+30];
        [self.layer addSublayer:self.circle2];
        
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.circle3 = [self shapeLayerWithFromRadius:width/2+3 WithToRadius:width/2+35];
        [self.layer addSublayer:self.circle3];
        
    });
    
    
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
                         [self.circle1 removeFromSuperlayer];
                         [self.circle2 removeFromSuperlayer];
                         [self.circle3 removeFromSuperlayer];
                     }];
    
    
    CGFloat width = self.frame.size.height;
    
    //    UIBezierPath *circlepath = [UIBezierPath bezierPathWithArcCenter:self.center radius:kradius startAngle:0 endAngle:M_PI*2 clockwise:NO];
    
    //    CAShapeLayer *circleLayer1 = [CAShapeLayer new];
    //    circleLayer1.fillColor = [UIColor greenColor].CGColor;
    //    circleLayer1.lineWidth = 0;
    //    circleLayer1.strokeColor = [UIColor orangeColor].CGColor;
    //    circleLayer1.path = circlepath.CGPath;
    
    
    UIBezierPath *checkpath = [UIBezierPath bezierPath];
    [checkpath setLineWidth:10];
    //     起点
    CGFloat number1 = 0.2*width;
    [checkpath moveToPoint:CGPointMake(kradius*2-number1, self.frame.size.height/2 - 10)];
    // 绘制线条
    [checkpath addLineToPoint:CGPointMake(kradius*2-0.05*width, self.frame.size.height/2+0.1*width)];
    [checkpath addLineToPoint:CGPointMake(kradius*2+number1, self.frame.size.height/2 -0.15*width)];
    
    CAShapeLayer *circleLayer = [CAShapeLayer new];
    circleLayer.fillColor = nil;
    circleLayer.lineWidth = 10;
    circleLayer.strokeColor = [UIColor redColor].CGColor;
    circleLayer.path = checkpath.CGPath;
    circleLayer.lineCap = kCALineCapRound;
    circleLayer.lineJoin = kCALineJoinRound;
    
    
    CABasicAnimation * fillAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    fillAnimation.duration = 0.8;
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
-(void)drawCircles{
    
    CGFloat width = self.frame.size.height;
    UIBezierPath *circlepath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((self.frame.size.width - self.frame.size.height)/2, circleWidth/2, width-circleWidth, width-circleWidth)];
    CAShapeLayer *circleLayer = [CAShapeLayer new];
    circleLayer.fillColor = self.backColor.CGColor;
    circleLayer.lineWidth = circleWidth;
    circleLayer.strokeColor = [UIColor orangeColor].CGColor;
    circleLayer.path = circlepath.CGPath;
    [self.layer addSublayer:circleLayer];
}
/**
 *  填充动画过程
 *
 *  @return CABasicAnimation
 */
- (CABasicAnimation *)animationWithFromRadius:(CGFloat )fromRadius WithToRadius:(CGFloat )toRadius{
    CABasicAnimation * fillAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    fillAnimation.duration = 1;
    fillAnimation.repeatCount = HUGE_VALF;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fillAnimation.fillMode = kCAFillModeForwards;
    fillAnimation.removedOnCompletion = NO;
    fillAnimation.fromValue = (__bridge id)([self noFillWith:fromRadius].CGPath);
    fillAnimation.toValue = (__bridge id)([self fillWith:toRadius].CGPath);
    
    return fillAnimation;
}
//透明度
-(CABasicAnimation *)makeOpacityAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.5f];
    animation.duration = 1.0f;
    animation.repeatCount = HUGE_VALF;
    
    return animation;
}
- (UIBezierPath *)noFillWith:(CGFloat )radius{
    NSLog(@"%f   %f",self.centerX,self.centerY);
    UIBezierPath * bezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.centerX-self.frame.origin.x, self.centerY-self.frame.origin.y) radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    return bezier;
}
- (UIBezierPath *)fillWith:(CGFloat )radius{
    NSLog(@"=====%f   %f",self.center.x,self.center.y);

    UIBezierPath * bezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.centerX-self.frame.origin.x, self.centerY-self.frame.origin.y) radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    return bezier;
}
- (CAShapeLayer *)shapeLayerWithFromRadius:(CGFloat )fromRadius WithToRadius:(CGFloat )toRadius{
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.lineWidth = 3;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    
    //    layer.lineCap = kCALineCapRound;
    layer.path = [self fillWith:toRadius].CGPath;
    layer.opacity = 1;
    
    
    CABasicAnimation * animation = [self animationWithFromRadius:fromRadius WithToRadius:toRadius];
    CABasicAnimation * opacityanimation = [self makeOpacityAnimation];
    
    [layer addAnimation:animation forKey:nil];
    [layer addAnimation:opacityanimation forKey:nil];
    
    return layer;
}


@end
