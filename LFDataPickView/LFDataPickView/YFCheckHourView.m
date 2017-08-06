//
//  YFCheckHourView.m
//  chrenai_iOS
//
//  Created by 吴林丰 on 2017/7/19.
//  Copyright © 2017年 yousails. All rights reserved.
//

#import "YFCheckHourView.h"

#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define YFColorRGB(r, g, b) YFColorRGBA((r), (g), (b), 255)

@interface YFCheckHourView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong,nonatomic) NSMutableArray* hour;
@property (strong,nonatomic) NSMutableArray* min;
@property (strong,nonatomic) NSString* selectHour;
@property (strong,nonatomic) NSString* selectMin;
@end

@implementation YFCheckHourView

+ (id)getCheckHourView{
    return  [[YFCheckHourView alloc] init];
}

-(void)initData{
    _hour = [[NSMutableArray alloc] initWithCapacity:1];
    _min = [[NSMutableArray alloc] initWithCapacity:1];
    _selectHour = @"00";
    _selectMin = @"1";
    for (int i = 0; i<100; i++) {
        NSString *text = [NSString stringWithFormat:@"%d小时",i];
        [_hour addObject:text];
    }
    
    for (int i = 0; i<60; i++) {
        NSString *text;
        if (i<=9) {
            text = [NSString stringWithFormat:@"0%d分",i];
        }else{
            text = [NSString stringWithFormat:@"%d分",i];
        }
        [_min addObject:text];
    }
    [self createUI];
}

- (void)createUI{
    UIPickerView *PickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 35, ScreenWidth,231)];
    PickerView.dataSource = self;
    PickerView.delegate = self;
    PickerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:PickerView];
    //拨到中间位置
    [PickerView selectRow:_hour.count*100/2 inComponent:0 animated:YES];
    [PickerView selectRow:_min.count*100/2 inComponent:1 animated:YES];
    UIView *pView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    pView.backgroundColor = [UIColor whiteColor];
    [self addSubview:pView];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, 2.5, 60, 30);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [cancelButton setTitleColor:[UIColor grayColor]  forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [pView addSubview:cancelButton];
    UIButton *determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    determineButton.frame = CGRectMake((ScreenWidth-50), 2.5, 40, 30);
    [determineButton setTitle:@"确定" forState:UIControlStateNormal];
    determineButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [determineButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [determineButton addTarget:self action:@selector(determineButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [pView addSubview:determineButton];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth - 123)/2, 7, 123, 21)];
    lab.backgroundColor = [UIColor clearColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor blackColor];
    lab.text = @"请选择时间";
    lab.font = [UIFont systemFontOfSize:15];
    [pView addSubview:lab];
}

//取消选择的勿扰时间
- (void)cancelButtonAction:(UIButton *)btn{
    if (self.btnBlcok) {
        self.btnBlcok(nil, 0, nil);
    }
}

//确定选择的勿扰时间
- (void)determineButtonAction:(UIButton *)btn{
    if (self.btnBlcok) {
        NSString *sendText = [NSString stringWithFormat:@"%d",[_selectHour intValue] * 60 + _selectMin.intValue];
        self.btnBlcok([NSString stringWithFormat:@"%@小时%@分",_selectHour,_selectMin], 1, sendText);
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _hour.count*200;
    }else if (component == 1){
        return  _min.count*200;
    }
    return 0;
}
//初始化每个组件每一行数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            if (row>=100) {
                return _hour[row%100];
            }
            return _hour[row];
        }
            break;
        case 1:
        {
            if (row>=60) {
               return _min[row%60];
            }
            return _min[row];
        }
            break;
        default:
            break;
    }
    return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        if (row>=100) {
            NSRange range = [_hour[row%100] rangeOfString:@"小时"]; //现获取要截取的字符串位置
            _selectHour = [_hour[row%100] substringToIndex:range.location]; //截取字符串
        }else{
            NSRange range = [_hour[row] rangeOfString:@"小时"]; //现获取要截取的字符串位置
            _selectHour = [_hour[row] substringToIndex:range.location]; //截取字符串
        }
    }
    if (component == 1) {
        if (row>=60) {
            NSRange range = [_min[row%60] rangeOfString:@"分"]; //现获取要截取的字符串位置
            _selectMin = [_min[row%60] substringToIndex:range.location]; //截取字符串
        }else{
            NSRange range = [_min[row] rangeOfString:@"分"]; //现获取要截取的字符串位置
            _selectMin = [_min[row] substringToIndex:range.location]; //截取字符串
        }
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 80;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor lightTextColor];
        }
    }
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

- (void)willMoveToSuperview:(UIView *)newSuperview{
    self.frame = CGRectMake(0, ScreenHeight - 264,ScreenWidth, 264);
    [self initData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
