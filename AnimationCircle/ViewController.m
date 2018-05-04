//
//  ViewController.m
//  AnimationCircle
//
//  Created by 李荣建 on 2018/5/3.
//  Copyright © 2018年 bool. All rights reserved.
//

#import "ViewController.h"
#import "AnimationCircleView.h"

@interface ViewController ()
@property (nonatomic,strong) AnimationCircleView *animationCircleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeBottom;
    }
    // Do any additional setup after loading the view, typically from a nib.
    self.animationCircleView = [AnimationCircleView new];
    self.animationCircleView.frame = CGRectMake(0, 100, self.view.frame.size.width, 200);
    self.animationCircleView.backColor = [UIColor cyanColor];
    self.animationCircleView.titleArr = @[@"故障码",@"就绪状态",@"p200",@"动力系统",@"协议"];
    [self.animationCircleView stoken];
    [self.view addSubview:self.animationCircleView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
