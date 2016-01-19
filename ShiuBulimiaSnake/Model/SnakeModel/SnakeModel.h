//
//  SnakeModel.h
//  ShiuBulimiaSnake
//
//  Created by 許佳豪 on 2016/1/19.
//  Copyright © 2016年 許佳豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
typedef enum {
    SnakeDirectionStatusUp,
    SnakeDirectionStatusDown,
    SnakeDirectionStatusLeft,
    SnakeDirectionStatusRight
}SnakeDirectionStatus;

@interface SnakeModel : NSObject

@property (nonatomic, assign) SnakeDirectionStatus snakeDirectionStatus;
@property (nonatomic, assign) NSInteger mainScreenHeight;
@property (nonatomic, assign) NSInteger mainScreenWidth;
+ (SnakeModel *)shared;
+ (NSMutableArray *)snakeBodyArrays;
+ (void)requireIncreasingSnakelength;
+ (void)resetGame:(CGSize)mainScreenSize;
+ (void)requireSnakeMove;
+ (bool)isSnakeHitOwnbody;
+ (bool)isSnakeHitPoint:(NSString *)fruitsCoordinate;
/*
   - 蛇的 Model
   - property 包括：
   - 蛇目前的身體每個座標點的 array，座標點是我們自己定義的
   Class，只有兩個屬性：x 與 y，都是 NSInteger
   - 蛇目前的行進方向
   - method 包括：
   - 要求蛇移動一格
   - 要求蛇增加長度
   - 詢問蛇現在頭是否碰到自己的身體
   - 詢問蛇的頭是否剛好碰到某個點
 */
@end
