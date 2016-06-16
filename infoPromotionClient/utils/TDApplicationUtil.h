//
//  TDApplicationUtil.h
//  infoPromotion
//
//  Created by 朱靓慈 on 15/3/4.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TDApplicationUtil : NSObject

+(void)makeSureLoginThen:(void (^)())complete controller:(UIViewController*)controller;

//弹出Hud
+(void)alertHud:(NSString *)text afterDelay:(NSTimeInterval)delay;

//弹出Hud 可定制字体(labelFont)
+(void)alertHud:(NSString *)text withLabelFont:(UIFont *)labelFont afterDelay:(NSTimeInterval)delay;

+(void)button:(UIButton *)button setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
+ (UIImage *)imageWithColor:(UIColor *)color;

//pop显示隐藏
+(void)showPop:(UIView *)popView toFrame:(CGRect)endFrame;
+(void)hidePop:(UIView *)popView toFrame:(CGRect)initFrame;

+ (UIViewController *)activityViewController;

//判断是否有相机访问权限
+(BOOL)hasAVAuthorization;

+(void)setMainNavigation:(UINavigationController *)navCtrl;
+(void)setWhiteNavigation:(UINavigationController *)navCtrl;
+(void)setTopicNavigation:(UINavigationController *)navCtrl;

//根据文字内容计算Label 高度
+(CGFloat)getLabelHeightWithFontSize:(CGFloat)fontSize withWordsContent:(NSString *)wordsContent andMarginHorizon:(CGFloat)marginHorizon;

//根据图片名称 生成背景
+(UIColor *)getBackgroundColorWithImageNameStr:(NSString *)imageNameStr;
+(UIColor *)getBackgroundColorWithImageNameStr:(NSString *)imageNameStr andBackgroundSize:(CGSize)backgroundSize;

//判断decimalTextField是否允许输入，比如价格只允许输入一个小数点和小数点后两位数，折扣只允许输入一个小数点和小数点后一位数,
//decimalLimit 限制小数点后几位，limit=1表示1位，limit=2表示两位
+(BOOL)judgeDecimalTextFieldAllowInput:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string decimalLimit:(int)limit;

//标识app是否是第一次启动
+ (BOOL) isAppFirstLoad;
@end
