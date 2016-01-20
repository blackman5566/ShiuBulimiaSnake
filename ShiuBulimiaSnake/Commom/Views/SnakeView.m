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
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int i = 1; i < [SnakeModel snakeBodyArrays].count; i++) {
        CGPoint point = [SnakeModel getXY:i];
        CGContextAddEllipseInRect(context, (CGRectMake(point.x, point.y, 15.0, 15.0)));
    }
    CGContextDrawPath(context, kCGPathFill);
    CGContextStrokePath(context);

    CGContextRef context2 = UIGraphicsGetCurrentContext();
    NSString *hitPoint = [SnakeModel hitBodyArrays][0];
    NSArray *XY = [hitPoint componentsSeparatedByString:@","];
    int x = [XY[0] intValue];
    int y = [XY[1] intValue];
    CGContextSetRGBFillColor(context, 1, 0, 0, 1.0);
    CGContextAddEllipseInRect(context2, (CGRectMake(x, y, 15.0, 15.0)));
    CGContextDrawPath(context2, kCGPathFill);
    CGContextStrokePath(context2);
}

- (void)initSnakeAndHitArrays {
    [[SnakeModel snakeBodyArrays] removeAllObjects];
    [[SnakeModel hitBodyArrays] removeAllObjects];
    for (int i = 160; i > 60; i -= 20) {
        NSString *string = [NSString stringWithFormat:@"%d,100", i];
        [[SnakeModel snakeBodyArrays] addObject:string];
    }
    [[SnakeModel hitBodyArrays] addObject:@"100,100"];
}

@end
