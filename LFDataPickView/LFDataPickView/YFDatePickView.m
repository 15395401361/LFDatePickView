//
//  YFDatePickView.m
//  DateDemo
//
//  Created by 吴林丰 on 2017/7/11.
//  Copyright © 2017年 吴林丰. All rights reserved.
//

#import "YFDatePickView.h"
#import "NSDate+LFDataAdd.h"
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
@interface YFDatePickView ()<UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;//取消按钮

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;//完成按钮

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//标题

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;//时间选择器

@end

@implementation YFDatePickView


+ (id)getDatePickView{
    NSArray *array = [[UINib nibWithNibName:@"YFDatePickView" bundle:nil] instantiateWithOwner:self options:nil];
    
    YFDatePickView *view;
    
    view = [array objectAtIndex:0];
    
    view.frame = CGRectMake(0, ScreenHeight - 264,ScreenWidth, 264);
    return view;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    NSDate* minDate = [NSDate date];
    NSDate* maxDate = [NSDate dateWithISOFormatString:@"3099-01-01 00:00:00 -0500"];
    self.datePicker.minimumDate = minDate;
    self.datePicker.maximumDate = maxDate;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
    self.datePicker.locale = locale;
    [self.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.finishBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.titleLabel.textColor = [UIColor blackColor];
}

- (void)setTitleWithString:(NSString *)title{
    self.titleLabel.text = title;
}

#pragma mark --- 点击了取消
- (IBAction)cancleAction:(id)sender {
    if (self.btnActionBlcok) {
        self.btnActionBlcok(nil, 0,nil);
    }
}

#pragma mark --- 点击了完成
- (IBAction)finishAction:(id)sender {
    if (self.btnActionBlcok) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
        NSString *DateTime = [formatter stringFromDate:self.datePicker.date];
        self.btnActionBlcok(DateTime, 1,DateTime);
    }
}
#pragma mark ---- 处理UI上的分割线
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    return pickerLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
