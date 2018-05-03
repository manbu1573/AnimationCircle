//
//  AnimationCircleView.h
//  dtcoretextdemo
//
//  Created by 李荣建 on 2018/5/3.
//  Copyright © 2018年 bool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationCircleView : UIView
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) UIColor *backColor;

-(void)stoken;
- (void)showEnd;

@end
