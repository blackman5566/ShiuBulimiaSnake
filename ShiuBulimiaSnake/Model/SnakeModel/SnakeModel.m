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
    if (!shared) {
        shared = [[self alloc] init];
    }
    return shared;
}

+ (NSMutableArray *)snakeBodyArrays {
    static NSMutableArray *shared = nil;
    if (!shared) {
        shared = [[NSMutableArray alloc] init];
        [shared addObject:@"160,100"];
        [shared addObject:@"140,100"];
        [shared addObject:@"120,100"];
        [shared addObject:@"100,100"];
    }
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

+ (bool)isSnakeHitOwnbody {
    return [[SnakeModel shared] isSnakeHitOwnbody];
}

+ (bool)isSnakeHitPoint:(NSString *)fruitsCoordinate {
    return [[SnakeModel shared] isSnakeHitPoint:fruitsCoordinate];
}

#pragma mark - private method

- (bool)isSnakeHitOwnbody {
    NSString *snakeHead = [SnakeModel snakeBodyArrays][0];
    for (int i = 1; i < [SnakeModel snakeBodyArrays].count; i++) {
        if ([snakeHead isEqualToString:[SnakeModel snakeBodyArrays][i]]) {
            return YES;
        }
    }
    return NO;
}

- (bool)isSnakeHitPoint:(NSString *)fruitsCoordinate {
    NSString *snakeHead = [SnakeModel snakeBodyArrays][0];
    if ([snakeHead isEqualToString:fruitsCoordinate]) {
        return YES;
    }
    return NO;
}

- (void)requireSnakeMove {
    self.isEatingFruit = YES;
    [self addSnakeBody];
}

- (void)SnakeMoveDown {
    NSString *snakeHead = [SnakeModel snakeBodyArrays][0];
    NSArray *headXY = [snakeHead componentsSeparatedByString:@","];
    int x = [headXY[0] intValue];
    int y = [headXY[1] intValue];
    y += 20;
    if (y > self.mainScreenHeight) {
        y -= self.mainScreenHeight;
    }
    NSString *newXY = [NSString stringWithFormat:@"%d,%d", x, y];
    [[SnakeModel snakeBodyArrays] insertObject:newXY atIndex:0];
    [self removeLastXY];
}

- (void)SnakeMoveUp {
    NSString *snakeHead = [SnakeModel snakeBodyArrays][0];
    NSArray *headXY = [snakeHead componentsSeparatedByString:@","];
    int x = [headXY[0] intValue];
    int y = [headXY[1] intValue];
    y -= 20;
    if (y < 0) {
        y += self.mainScreenHeight;
    }
    NSString *newXY = [NSString stringWithFormat:@"%d,%d", x, y];
    [[SnakeModel snakeBodyArrays] insertObject:newXY atIndex:0];
    [self removeLastXY];
}

- (void)SnakeMoveLeft {
    NSString *snakeHead = [SnakeModel snakeBodyArrays][0];
    NSArray *headXY = [snakeHead componentsSeparatedByString:@","];
    int x = [headXY[0] intValue];
    int y = [headXY[1] intValue];
    x -= 20;
    if (x < 0) {
        x += self.mainScreenWidth;
    }
    NSString *newXY = [NSString stringWithFormat:@"%d,%d", x, y];
    [[SnakeModel snakeBodyArrays] insertObject:newXY atIndex:0];
    [self removeLastXY];
}

- (void)SnakeMoveRight {
    NSString *snakeHead = [SnakeModel snakeBodyArrays][0];
    NSArray *headXY = [snakeHead componentsSeparatedByString:@","];
    int x = [headXY[0] intValue];
    int y = [headXY[1] intValue];
    x += 20;
    if (x > self.mainScreenHeight) {
        x -= self.mainScreenHeight;
    }
    NSString *newXY = [NSString stringWithFormat:@"%d,%d", x, y];
    [[SnakeModel snakeBodyArrays] insertObject:newXY atIndex:0];
    NSLog(@"SnakeMoveRight");
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

- (void)requireIncreasingSnakelength {
    self.isEatingFruit = NO;
    [self addSnakeBody];
}

- (void)resetGame:(CGSize)mainScreenSize {
    self.snakeDirectionStatus = SnakeDirectionStatusRight;
    self.mainScreenHeight = mainScreenSize.height;
    self.mainScreenWidth = mainScreenSize.width;
}

@end
