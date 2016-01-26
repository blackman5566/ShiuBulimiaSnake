//
//  SnakeView.m
//  ShiuBulimiaSnake
//
//  Created by 許佳豪 on 2016/1/19.
//  Copyright © 2016年 許佳豪. All rights reserved.
//

#import "SnakeView.h"
#import "SnakeModel.h"

@implementation SnakeView

- (id)init {
    self = [super init];
    if (self) {
        [self initSnakeAndHitArrays];
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // 畫蛇
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int i = 1; i < [SnakeModel snakeBodyArrays].count; i++) {
        CGPoint point = [SnakeModel snakePoint:[SnakeModel snakeBodyArrays] index:i];
        CGContextAddEllipseInRect(context, (CGRectMake(point.x, point.y, 15.0, 15.0)));
    }
    CGContextDrawPath(context, kCGPathFill);
    CGContextStrokePath(context);
    
    // 畫食物
    CGContextRef foodContext = UIGraphicsGetCurrentContext();
    CGPoint point = [SnakeModel snakePoint:[SnakeModel hitBodyArrays] index:0];
    CGContextSetRGBFillColor(foodContext, 1, 0, 0, 1.0);
    CGContextAddEllipseInRect(foodContext, (CGRectMake((int)point.x, (int)point.y, 20.0, 20.0)));
    CGContextDrawPath(foodContext, kCGPathFill);
    CGContextStrokePath(foodContext);
}

- (void)initSnakeAndHitArrays {
    [[SnakeModel snakeBodyArrays] removeAllObjects];
    [[SnakeModel hitBodyArrays] removeAllObjects];
    for (int i = 160; i > 60; i -= pointDistance) {
        NSString *string = [NSString stringWithFormat:@"%d,100", i];
        [[SnakeModel snakeBodyArrays] addObject:string];
    }
    [[SnakeModel hitBodyArrays] addObject:@"200,100"];
}

@end
