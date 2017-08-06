//
//  YFDatePickView.h
//  DateDemo
//
//  Created by 吴林丰 on 2017/7/11.
//  Copyright © 2017年 吴林丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFDatePickView : UIView
#pragma mark --- 回调。将当前选择的时间返回值上一层
@property (strong,nonatomic) void(^ btnActionBlcok)(NSString *content,NSInteger btnIndex,NSString *sendText);

//初始化View
+ (id)getDatePickView;

//设置时间
- (void)setTitleWithString:(NSString *)title;

@end
