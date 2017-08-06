//
//  YFCheckHourView.h
//  chrenai_iOS
//
//  Created by 吴林丰 on 2017/7/19.
//  Copyright © 2017年 yousails. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFCheckHourView : UIView
#pragma Mark  --- 开始时间和结束时间处理block 
@property (strong,nonatomic) void(^btnBlcok)(NSString *content,NSInteger btnIndex,NSString *sendText);
+ (id)getCheckHourView;

@end
