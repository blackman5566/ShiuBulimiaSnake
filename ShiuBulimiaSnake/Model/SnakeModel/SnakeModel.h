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
/*
 @abstract 貪食蛇目前的身體每個座標點的 array，座標點是我們自己定義的。
 */
+ (NSMutableArray *)snakeBodyArrays;

/*
 @abstract 儲存水果的座標
 */
+ (NSMutableArray *)hitBodyArrays;

/*
 @abstract 要求貪食蛇增加長度
 */
+ (void)requireIncreasingSnakelength;

/*
 @abstract 重新開始遊戲
 */
+ (void)resetGame:(CGSize)mainScreenSize;

/*
 @abstract 要求貪食蛇移動
 */
+ (void)requireSnakeMove;

/*
 @abstract 詢問貪食蛇現在頭是否碰到自己的身體
 */
+ (bool)isSnakeHitOwnbody;

/*
 @abstract 詢問貪食蛇的頭是否剛好碰到某個點
 */
+ (bool)isSnakeHitPoint;

/*
 @abstract 改變貪食蛇現在行徑的方向
 */
+ (void)isSnakeDirectionStatus:(SnakeDirectionStatus)SnakeDirectionStatus;

/*
 @abstract 產生新水果點
 */
+ (void)creatNewHitPoint;

/*
 @abstract 回傳貪食蛇目前的身體座標點
 */
+ (CGPoint)getXY:(NSInteger)index;

@end
