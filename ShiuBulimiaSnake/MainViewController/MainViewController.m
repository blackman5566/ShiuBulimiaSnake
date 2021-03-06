//
//  MainViewController.m
//  ShiuBulimiaSnake
//
//  Created by 許佳豪 on 2016/1/19.
//  Copyright © 2016年 許佳豪. All rights reserved.
//

#import "MainViewController.h"
#import "SnakeView.h"
#import "SnakeModel.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (nonatomic, strong) SnakeView *snakeView;

@property (nonatomic, weak) NSTimer *timer;
@end

@implementation MainViewController

#pragma mark - UISwipeGestureRecognizer Action

- (IBAction)didSwipe:(UISwipeGestureRecognizer *)sender {
    if ([SnakeModel isSnakeCurrentDirection]) {
        if (sender.direction ==UISwipeGestureRecognizerDirectionUp) {
            [SnakeModel isSnakeDirectionStatus:SnakeDirectionStatusUp];
            
        }else if(sender.direction ==UISwipeGestureRecognizerDirectionDown){
            [SnakeModel isSnakeDirectionStatus:SnakeDirectionStatusDown];
        }
    }else{
        if (sender.direction ==UISwipeGestureRecognizerDirectionLeft) {
            [SnakeModel isSnakeDirectionStatus:SnakeDirectionStatusLeft];
            
        }else if(sender.direction ==UISwipeGestureRecognizerDirectionRight){
            [SnakeModel isSnakeDirectionStatus:SnakeDirectionStatusRight];
        }
        
    }
}

#pragma mark - private method

- (void)initSnakeView {
    self.snakeView = [[SnakeView alloc] init];
    self.snakeView.frame = self.mainView.frame;
    [self.mainView addSubview:self.snakeView];
}

- (void)initAlertAction:(NSString *)message {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"遊戲"
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler: ^(UIAlertAction *action)
                                {
                                    [weakSelf resetGame];
                                    
                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)resetGame {
    [self initSnakeView];
    [SnakeModel resetGame:self.mainView.frame.size];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(requireSnakeMove)
                                                userInfo:nil
                                                 repeats:YES];
    [self.timer fire];
}
- (void)requireSnakeMove {
    [SnakeModel requireSnakeMove];
    [self.snakeView setNeedsDisplay];
    if ([SnakeModel isSnakeHitPoint]) {
        [SnakeModel requireIncreasingSnakelength];
        [SnakeModel creatNewHitPoint];
    }
    
    if ([SnakeModel isSnakeHitBody]) {
        [self.mainView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.timer invalidate];
        [self initAlertAction:@"重新開始"];
    }
}

#pragma  mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSnakeView];
}

- (void)viewDidAppear:(BOOL)animated {
    [self initAlertAction:@"遊戲開始"];
}

@end
