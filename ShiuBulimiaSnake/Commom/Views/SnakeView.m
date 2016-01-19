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
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = 40.0;
    CGPoint point =  [self getXY:0];
    [path moveToPoint:CGPointMake(point.x, point.y)];
    for (int i = 1; i < [SnakeModel snakeBodyArrays].count; i++) {
        CGPoint point =  [self getXY:i];
        [path addLineToPoint:CGPointMake(point.x, point.y)];
    }
    [[UIColor redColor] setStroke];  //設定線條顏色
    [path stroke];
}

- (CGPoint)getXY:(NSInteger)index {
    NSString *snakeHead = [SnakeModel snakeBodyArrays][index];
    NSArray *headXY = [snakeHead componentsSeparatedByString:@","];
    int x = [headXY[0] intValue];
    int y = [headXY[1] intValue];
    CGPoint xyPoint = CGPointMake(x, y);
    return xyPoint;
}
@end
