//
//  TDImageUtil.h
//  infoPromotion
//
//  Created by 朱靓慈 on 15/3/2.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDParamUtil.h"
#import "AFNetworking.h"
#import "CocoaSecurity.h"


static NSString *IMAGETYPE_IS_JPG = @"jpg";
static NSString *IMAGETYPE_IS_PNG = @"png";
@interface TDImageUtil : NSObject

//上传图片
+(void) uploadImage:(UIImage *)image imageType:(NSString *)imageType  mainFileName:(NSString *)mainFileName attributes:(NSDictionary *)attributes success:(void(^)(NSDictionary *data))success fail:(void(^)(NSError * error))fail;



+(NSURL *)getImageURLById:(NSString*)imageId;

+(NSURL *)getThumbImageURLById:(NSString *)imageId;

+(NSURL *)getTemplateImageURLById:(NSString *)imageId;

+(CGSize) getImageSizeWithName:(NSString *)imageName;

+(CGSize)downloadImageSizeWithURL:(id)imageURL;


+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;

//改变图片大小
+(UIImage *) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

+(UIImage *)getImageByUrlStr:(NSString *)urlStr;

//根据指定尺寸生成缩略图
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;
@end
