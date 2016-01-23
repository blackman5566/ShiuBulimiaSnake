//
//  SnakeModel.m
//  ShiuBulimiaSnake
//
//  Created by 許佳豪 on 2016/1/19.
//  Copyright © 2016年 許佳豪. All rights reserved.
//


#import "SnakeModel.h"

@interface SnakeModel ()

@property (nonatomic, assign) BOOL isEatingFruit;

@end

@implementation SnakeModel

#pragma mark - class Method

+ (SnakeModel *)shared {
    static SnakeModel *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

+ (NSMutableArray *)snakeBodyArrays {
    static NSMutableArray *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[NSMutableArray alloc] init];
    });
    return shared;
}

+ (NSMutableArray *)hitBodyArrays {
    static NSMutableArray *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[NSMutableArray alloc] init];
    });
    return shared;
}

+ (void)resetGame:(CGSize)mainScreenSize {
    [[SnakeModel shared] resetGame:mainScreenSize];
}

+ (void)requireIncreasingSnakelength {
    [[SnakeModel shared] requireIncreasingSnakelength];
}

+ (void)requireSnakeMove {
    [[SnakeModel shared] requireSnakeMove];
}

+ (bool)isSnakeHitBody {
    return [[SnakeModel shared] isSnakeHitBody];
}

+ (bool)isSnakeHitPoint {
    return [[SnakeModel shared] isSnakeHitPoint];
}

+ (void)isSnakeDirectionStatus:(SnakeDirectionStatus)SnakeDirectionStatus {
    [[SnakeModel shared] snakeDirectionStatus:SnakeDirectionStatus];
}

+ (CGPoint)getPoint:(NSArray *)array index:(NSInteger)index {
    return [[SnakeModel shared] getPoint:array index:index];
}

+ (void)creatNewHitPoint {
    [[SnakeModel shared] creatNewHitPoint];
}

+ (bool)isSnakeCurrentDirection {
    return [[SnakeModel shared] isSnakeCurrentDirection];
}

#pragma mark - private method

- (bool)isSnakeHitBody {
    NSString *snakeHead = [SnakeModel snakeBodyArrays][0];
    for (int i = 1; i < [SnakeModel snakeBodyArrays].count; i++) {
        if ([snakeHead isEqualToString:[SnakeModel snakeBodyArrays][i]]) {
            return YES;
        }
    }
    return NO;
}

- (bool)isSnakeHitPoint {
    CGPoint snakeHeadPoint = [self getPoint:[SnakeModel snakeBodyArrays] index:0];
    NSMutableArray *snakeRangeArrays = [NSMutableArray new];
    for (int i = 1; i < 10; i++) {
        for (int j = 1; j < 10; j++) {
            NSString *string = [NSString stringWithFormat:@"%d,%d", (int)snakeHeadPoint.x + i, (int)snakeHeadPoint.y + j];
            [snakeRangeArrays addObject:string];
        }
    }

    CGPoint hitPoint = [self getPoint:[SnakeModel hitBodyArrays] index:0];
    NSMutableArray *hitRangeArrays = [NSMutableArray new];
    for (int i = 1; i < 15; i++) {
        for (int j = 1; j < 15; j++) {
            NSString *string = [NSString stringWithFormat:@"%d,%d", (int)hitPoint.x + i, (int)hitPoint.y + j];
            [hitRangeArrays addObject:string];
        }
    }
    for (int j = 1; j < hitRangeArrays.count; j++) {
        for (int i = 1; i < snakeRangeArrays.count; i++) {
            if ([hitRangeArrays[j] isEqualToString:snakeRangeArrays[i]]) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)requireSnakeMove {
    self.isEatingFruit = YES;
    [self addSnakeBody];
}

- (void)SnakeMoveDown {
    CGPoint point =  [self getPoint:[SnakeModel snakeBodyArrays] index:0];
    point.y += pointDistance;
    if (point.y > self.mainScreenHeight) {
        point.y = 0;
    }
    NSString *newXY = [NSString stringWithFormat:@"%d,%d", (int)point.x, (int)point.y];
    [[SnakeModel snakeBodyArrays] insertObject:newXY atIndex:0];
    [self removeLastXY];
}

- (void)SnakeMoveUp {
    CGPoint point =  [self getPoint:[SnakeModel snakeBodyArrays] index:0];
    point.y -= pointDistance;
    if (point.y < 0) {
        point.y = self.mainScreenHeight;
    }
    NSString *newXY = [NSString stringWithFormat:@"%d,%d", (int)point.x, (int)point.y];
    [[SnakeModel snakeBodyArrays] insertObject:newXY atIndex:0];
    [self removeLastXY];
}

- (void)SnakeMoveLeft {
    CGPoint point =  [self getPoint:[SnakeModel snakeBodyArrays] index:0];
    point.x -= pointDistance;
    if (point.x < 0) {
        point.x = self.mainScreenWidth;
    }
    NSString *newXY = [NSString stringWithFormat:@"%d,%d", (int)point.x, (int)point.y];
    [[SnakeModel snakeBodyArrays] insertObject:newXY atIndex:0];
    [self removeLastXY];
}

- (void)SnakeMoveRight {
    CGPoint point =  [self getPoint:[SnakeModel snakeBodyArrays] index:0];
    point.x += pointDistance;
    if (point.x > self.mainScreenWidth) {
        point.x = 0;
    }
    NSString *newXY = [NSString stringWithFormat:@"%d,%d", (int)point.x, (int)point.y];
    [[SnakeModel snakeBodyArrays] insertObject:newXY atIndex:0];
    [self removeLastXY];
}

- (void)removeLastXY {
    if (self.isEatingFruit) {
        [[SnakeModel snakeBodyArrays] removeLastObject];
    }
}

- (void)addSnakeBody {
    switch (self.snakeDirectionStatus) {
        case SnakeDirectionStatusUp:
            [self SnakeMoveUp];
            break;
        case SnakeDirectionStatusDown:
            [self SnakeMoveDown];
            break;
        case SnakeDirectionStatusLeft:
            [self SnakeMoveLeft];
            break;
        case SnakeDirectionStatusRight:
            [self SnakeMoveRight];
            break;
        default:
            break;
    }
}

- (void)snakeDirectionStatus:(SnakeDirectionStatus)SnakeDirectionStatus {
    self.snakeDirectionStatus = SnakeDirectionStatus;
}

- (void)requireIncreasingSnakelength {
    self.isEatingFruit = NO;
    [self addSnakeBody];
}

- (void)resetGame:(CGSize)mainScreenSize {
    self.snakeDirectionStatus = SnakeDirectionStatusRight;
    self.mainScreenHeight = mainScreenSize.height;
    self.mainScreenWidth = mainScreenSize.width;
}

- (CGPoint)getPoint:(NSArray *)array index:(NSInteger)index {
    NSString *snakeHead = array[index];
    NSArray *headXY = [snakeHead componentsSeparatedByString:@","];
    int x = [headXY[0] intValue];
    int y = [headXY[1] intValue];
    CGPoint point = CGPointMake(x, y);
    return point;
}

- (void)creatNewHitPoint {
    [[SnakeModel hitBodyArrays] removeAllObjects];
    int x = 30 + (arc4random() % (self.mainScreenWidth - 50));
    int y = 30 + (arc4random() % (self.mainScreenHeight - 50));
    [[SnakeModel hitBodyArrays] addObject:[NSString stringWithFormat:@"%d,%d", x, y]];

}

- (bool)isSnakeCurrentDirection {
    bool isDirection;
    switch (self.snakeDirectionStatus) {
        case SnakeDirectionStatusUp:
        case SnakeDirectionStatusDown:
            isDirection = NO;
            break;
        case SnakeDirectionStatusLeft:
        case SnakeDirectionStatusRight:
            isDirection = YES;
        default:
            break;
    }
    return isDirection;
}

@end
