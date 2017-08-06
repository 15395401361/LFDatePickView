//
//  NSDate+LFDataAdd.m
//  LFDataPickView
//
//  Created by 吴林丰 on 2017/8/6.
//  Copyright © 2017年 吴林丰. All rights reserved.
//

#import "NSDate+LFDataAdd.h"

@implementation NSDate (LFDataAdd)
+ (NSDate *)dateWithISOFormatString:(NSString *)dateString {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    });
    return [formatter dateFromString:dateString];
}
@end
