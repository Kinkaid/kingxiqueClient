//
//  TDImageUtil.m
//  infoPromotion
//
//  Created by 朱靓慈 on 15/3/2.
//  Copyright (c) 2015年 com.tgram.ios. All rights reserved.
//

#import "TDImageUtil.h"
#import "MBProgressHUD.h"
#import "UpYun.h"


@implementation TDImageUtil

+(void) uploadImage:(UIImage *)image imageType:(NSString *)imageType  mainFileName:(NSString *)mainFileName attributes:(NSDictionary *)attributes success:(void(^)(NSDictionary *data))success fail:(void(^)(NSError * error))fail{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    UpYun *uy = [[UpYun alloc] init];
    NSData * imageData = [[NSData alloc]init];
    if (!imageType) {
        imageType = IMAGETYPE_IS_JPG;
    }
    if ([imageType isEqualToString:IMAGETYPE_IS_JPG]) {
        imageData = UIImageJPEGRepresentation(image, 0.5f);
    } else if([imageType isEqualToString:IMAGETYPE_IS_PNG]){
        imageData = UIImagePNGRepresentation(image);
    }
    NSString *imageWidth = [TDNumberUtil decimalwithFormat:@"0" floatV:image.size.width];
    NSString *imageHeight = [TDNumberUtil decimalwithFormat:@"0" floatV:image.size.height];
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];//设备唯一标识符
    
    NSDate *date = [NSDate date];
    NSString *timeString = [TDDateUtil stringFromDate:date withFormatterString:@"YYYYMMddHHmmss"];
    
    NSString *imgNamePrefix = [CocoaSecurity md5:[NSString stringWithFormat:@"%@%@",identifierForVendor,timeString]].hexLower;
    NSString *saveKey = [NSString stringWithFormat:@"%@/%d/%d/%@_%@X%@.%@",mainFileName,[self getYear:date],[self getMonth:date],imgNamePrefix,imageWidth,imageHeight,imageType];
    
    
    uy.successBlocker = ^(id data){
        hud.hidden=YES;
        success(data);
    };
    uy.failBlocker = ^(NSError * error){
        hud.hidden=YES;
        [TDApplicationUtil alertHud:[error localizedDescription] afterDelay:1];
        fail(error);
    };
    
    [uy uploadFile:imageData saveKey:saveKey];
    
    
}
+(NSString * )getSaveKey {
    /**
     *	@brief	方式1 由开发者生成saveKey
     */
    NSDate *d = [NSDate date];
    return [NSString stringWithFormat:@"/%d/%d/%.0f.jpg",[self getYear:d],[self getMonth:d],[[NSDate date] timeIntervalSince1970]];
    
    /**
     *	@brief	方式2 由服务器生成saveKey
     */
    //    return [NSString stringWithFormat:@"/{year}/{mon}/{filename}{.suffix}"];
    
    /**
     *	@brief	更多方式 参阅 http://wiki.upyun.com/index.php?title=Policy_%E5%86%85%E5%AE%B9%E8%AF%A6%E8%A7%A3
     */
    
}
+ (int)getYear:(NSDate *) date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    int year=[comps year];
    return year;
}

+ (int)getMonth:(NSDate *) date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    int month = [comps month];
    return month;
}

//+(void) uploadImage:(UIImage *)image userId:(NSString *)userId success:(void(^)(NSDictionary *responseObject,NSDictionary *data,NSString *msg))success failActions:(NSDictionary *)failDic{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    NSData * jpgImage = UIImageJPEGRepresentation(image, 0.5f);
//    NSString *serviceMethodUrl = [NSString stringWithFormat:@"%@%@",SERVICEURL, @"/file"];
//    NSString *imageWidth = [TDNumberUtil decimalwithFormat:@"0" floatV:image.size.width];
//    NSString *imageHeight = [TDNumberUtil decimalwithFormat:@"0" floatV:image.size.height];
//    NSDictionary *params = @{@"width":imageWidth, @"height":imageHeight, @"contentType":@"image/jpeg",@"userId":userId};
//    NSDictionary *fileInfo = @{@"file_info":[TDDataUtil dictionaryToJson:params]};
//    NSDictionary *serviceParams = [TDParamUtil formatServiceParam:fileInfo];
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:serviceMethodUrl parameters:serviceParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:jpgImage name:@"file" fileName:@"" mimeType:@"image/jpeg"];
//    } error:nil];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSProgress *progress = nil;
//    
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        
//        if (error) {
//            NSLog(@"Error: %@", error);
//            hud.labelText = [NSString stringWithFormat:@"%@",[error localizedDescription]];
//            hud.mode = MBProgressHUDModeText;
//            [hud hide:YES afterDelay:0.5];
//            
//        } else {
//            NSDictionary *obj = responseObject;
//            id code = [obj valueForKey:@"code"];
//            
//            if([[NSString stringWithFormat:@"%@",code] isEqualToString:@"1"]){
//                success(obj,[obj valueForKey:@"data"],[obj valueForKey:@"msg"]);
//            }else{
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    void(^failBlock)(NSURLResponse *response,NSDictionary *data,NSString *msg) =[failDic objectForKey:[[obj objectForKey:@"code"] stringValue]];
//                    if (failBlock) {
//                        failBlock(obj,[obj valueForKey:@"data"],[obj valueForKey:@"msg"]);
//                    }
//                });
//            }
//            hud.hidden=YES;
//            
//        }
//    }];
//    
//    [uploadTask resume];
//    
//}
+(NSURL *)getImageURLById:(NSString *)imageId{
    NSString *urlStr=[[NSString alloc] initWithFormat:@"%@%@",IMAGEURL,imageId];
    NSURL *url=[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return url;
}
+(NSURL *)getThumbImageURLById:(NSString *)imageId{
    NSString *urlStr=[[NSString alloc] initWithFormat:@"%@%@!small",IMAGEURL,imageId];
    NSURL *url=[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return url;
}
+(NSURL *)getTemplateImageURLById:(NSString *)imageId{
    NSString *serviceUrl = @"http://183.129.157.118:88/web-magpie/service";
    NSDictionary *paramDic=[TDParamUtil formatServiceParam:@{@"fileId":imageId}];
    NSString *urlStr=[[NSString alloc] initWithFormat:@"%@/file?appid=%@&token=%@&fileId=%@",serviceUrl,APPID,[paramDic objectForKey:@"token"],[paramDic objectForKey:@"fileId"]];
    NSURL *url=[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return url;
}
+(CGSize) getImageSizeWithName:(NSString *)imageName{
    NSRange dotIndex = [imageName rangeOfString:@"."];
    NSRange underlineIndex = [imageName rangeOfString:@"_"];
    NSString *imgSizeStr = [imageName substringToIndex:dotIndex.location];
    imgSizeStr = [imgSizeStr substringFromIndex:underlineIndex.location+1];
    NSArray *imgSizeArray = [imgSizeStr componentsSeparatedByString:@"X"];
    CGFloat imgWidth = [[imgSizeArray objectAtIndex:0] floatValue];
    CGFloat imgHeight = [[imgSizeArray objectAtIndex:1] floatValue];
    CGSize imgSize = CGSizeMake(imgWidth, imgHeight);
    return  imgSize;
}
+(CGSize)downloadImageSizeWithURL:(id)imageURL
{
    NSURL *URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;
    NSString* absoluteString = URL.absoluteString;
#ifdef dispatch_main_sync_safe
    if([[SDImageCache sharedImageCache] diskImageExistsWithKey:absoluteString])
    {
        UIImage* image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:absoluteString];
        if(!image)
        {
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:URL.absoluteString];
            image = [UIImage imageWithData:data];
        }
        if(!image)
        {
            return image.size;
        }
    }
#endif
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size= [self downloadPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =[self downloadGIFImageSizeWithRequest:request];
    }
    else{
        size = [self downloadJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
#ifdef dispatch_main_sync_safe
            [[SDImageCache sharedImageCache] storeImage:image recalculateFromImage:YES imageData:data forKey:URL.absoluteString toDisk:YES];
#endif
            size = image.size;
        }
    }
    return size;
}
+(CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+(CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+(CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}
-(id)diskImageDataBySearchingAllPathsForKey:(id)key{return nil;}
/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}
//改变图片大小
+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}
+(UIImage *)getImageByUrlStr:(NSString *)urlStr{
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
    UIImage *image = [UIImage imageWithData:imageData];
    return image;
}

//根据指定尺寸生成缩略图
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}
@end
