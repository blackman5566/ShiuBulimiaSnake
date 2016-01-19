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

@property (weak, nonatomic) IBOutlet SnakeView *sankeView;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation MainViewController

#pragma mark - private method

- (void)initAlertAction {
    UIAlertController *alert =   [UIAlertController
                                  alertControllerWithTitle:@"遊戲"
                                                   message:@"開始"
                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                          style:UIAlertActionStyleDefault
                                        handler: ^(UIAlertAction *action)
                                {
                                    [self resetGame];

                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)resetGame {
    [SnakeModel resetGame:self.sankeView.frame.size];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(requireSnakeMove)
                                                userInfo:nil
                                                 repeats:YES];
    [self.timer fire];
}
- (void)requireSnakeMove {
    [SnakeModel requireSnakeMove];
    [self.sankeView setNeedsDisplay];
}
#pragma  mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewDidAppear:(BOOL)animated {
    [self initAlertAction];
}
- (IBAction)test:(id)sender {
}

@end
