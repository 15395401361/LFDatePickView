//
//  ViewController.m
//  LFDataPickView
//
//  Created by 吴林丰 on 2017/8/6.
//  Copyright © 2017年 吴林丰. All rights reserved.
//

#import "ViewController.h"
#import "YFDatePickView.h"
#import "YFCheckHourView.h"
#import "HideView.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (strong,nonatomic) YFDatePickView *dateView;//时间选择器
@property (strong,nonatomic) YFCheckHourView *hourView;//时分时间选择
@property (strong,nonatomic) HideView *transparentView;//黑色蒙层
@end

@implementation ViewController
#pragma mark --- 蒙版
- (HideView *)transparentView{
    if (_transparentView == nil) {
        _transparentView = [HideView getHideViewFromWindow:self.view.window];
        _transparentView.isHide = NO;
    }
    return _transparentView;
}

#pragma mark --- 时间选择器
- (YFDatePickView *)dateView{
    if (_dateView == nil) {
        _dateView = [YFDatePickView getDatePickView];
        WS(weakSelf)
        _dateView.btnActionBlcok = ^(NSString *content, NSInteger btnIndex, NSString *sendText) {
            if (btnIndex == 0) {
                [weakSelf.dateView removeFromSuperview];
                weakSelf.transparentView.hidden = YES;
            }else{
                [weakSelf.dateView removeFromSuperview];
                weakSelf.transparentView.hidden = YES;
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:content preferredStyle:UIAlertControllerStyleAlert];
                [weakSelf presentViewController:alert animated:YES completion:nil];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
                    [alert dismissViewControllerAnimated:YES completion:nil];
                }]];
                
            }
        };
    }
    return _dateView;
}

#pragma mark --- 一次签到的时间选择
- (YFCheckHourView *)hourView{
    if (_hourView == nil) {
        _hourView = [YFCheckHourView getCheckHourView];
        WS(weakSelf)
        _hourView.btnBlcok = ^(NSString *content, NSInteger btnIndex, NSString *sendText) {
            if (btnIndex == 0) {
                weakSelf.transparentView.hidden = YES;
                [weakSelf.hourView removeFromSuperview];
            }else{
                [weakSelf.hourView removeFromSuperview];
                weakSelf.transparentView.hidden = YES;
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:content preferredStyle:UIAlertControllerStyleAlert];
                [weakSelf presentViewController:alert animated:YES completion:nil];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
                    [alert dismissViewControllerAnimated:YES completion:nil];
                }]];
            }
        };
    }
    return _hourView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)dateAction:(id)sender {
    
    if (self.transparentView.subviews.count > 0 && [self.transparentView.subviews[0] isKindOfClass:[YFDatePickView class]]) {
        self.transparentView.hidden = NO;
    }else{
        [self.transparentView addSubview:self.dateView];
        self.transparentView.hidden = NO;
    }
}



- (IBAction)hourAction:(id)sender {
    if (self.transparentView.subviews.count > 0 &&[self.transparentView.subviews[0] isKindOfClass:[YFCheckHourView class]]) {
        self.transparentView.hidden = NO;
    }else{
        [self.dateView removeFromSuperview];
        [self.transparentView addSubview:self.hourView];
        self.transparentView.hidden = NO;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
