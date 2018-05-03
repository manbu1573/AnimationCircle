//
//  UIView+BBD.m
//  WaspButlerApp
//
//  Created by 杜守鹏 on 2017/4/10.
//  Copyright © 2017年 杜守鹏. All rights reserved.
#import "UIView+WB.h"
#import <objc/runtime.h>

@implementation UIView (WB)


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
static NSString *_strFlag;

- (void)setStrFlag:(NSString *)flag {
    // void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
    objc_setAssociatedObject(self, &_strFlag, flag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)strFlag {
    // id objc_getAssociatedObject(id object, const void *key)
    return objc_getAssociatedObject(self, &_strFlag);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)cornerRadius:(CGFloat)radius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = radius;
}

- (void)cornerRadius:(CGFloat)radius borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = radius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}

- (void)borderWithColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth
{
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}

- (void)makeRoundedCorner:(UIRectCorner)byRoundingCorners cornerRadius:(CGSize)cornerRadius
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:byRoundingCorners cornerRadii:cornerRadius];
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    self.layer.mask = shape;
}

- (UIView *)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}

- (UIImage *)screenShot
{
    CGRect rect = self.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}



@end
