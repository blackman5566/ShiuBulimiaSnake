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

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int i = 1; i < [SnakeModel snakeBodyArrays].count; i++) {
        CGPoint point = [SnakeModel getXY:i];
        CGContextAddEllipseInRect(context, (CGRectMake(point.x, point.y, 10.0, 10.0)));
    }
    CGContextDrawPath(context, kCGPathFill);
    CGContextStrokePath(context);
    
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    NSString *hitPoint = [SnakeModel hitBodyArrays][0];
    NSArray *XY = [hitPoint componentsSeparatedByString:@","];
    int x = [XY[0] intValue];
    int y = [XY[1] intValue];
    CGContextSetStrokeColorWithColor(context2, [UIColor orangeColor].CGColor);
    CGContextAddEllipseInRect(context2, (CGRectMake(x, y, 20.0, 20.0)));
    CGContextDrawPath(context2, kCGPathFill);
    CGContextStrokePath(context2);
}

@end
