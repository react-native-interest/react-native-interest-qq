//
//  RCTInterestQQ.m
//  RCTInterestQQ
//
//  Created by Rabbit on 2018/8/25.
//  Copyright © 2018年 Rabbit. All rights reserved.
//

#import "RCTInterestQQ.h"

//#import "RCTQQSDK.h"

NSString *QQ_NOT_INSTALLED = @"QQ Client is not installed";
NSString *QQ_LOGIN_ERROR = @"QQ login error";
NSString *QQ_LOGIN_CANCEL = @"QQ login cancelled";
NSString *QQ_IMAGE_PARAM_INCORRECT = @"image param is incorrect";
NSString *QQ_LOGIN_NETWORK_ERROR = @"QQ login network error";
NSString *QQ_SHARE_CANCEL = @"QQ share cancelled by user";
NSString *QQ_OTHER_ERROR = @"other error happened";
NSString *appId = @"";

@implementation RCTInterestQQ {
    TencentOAuth *tencentOAuth;
    RCTPromiseResolveBlock loginResolve;
    RCTPromiseRejectBlock loginReject;
    RCTPromiseResolveBlock logoutResolve;
    RCTPromiseRejectBlock logoutReject;
    RCTPromiseResolveBlock shareResolve;
    RCTPromiseRejectBlock shareReject;
}

RCT_EXPORT_MODULE(RNInterestQQ)

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        [self initTencentOAuth];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(handleOpenURLNotification:)
//                                                     name:@"RCTOpenURLNotification"
//                                                   object:nil];
//    }
//    return self;
//}
#pragma mark -- 单例
static RCTInterestQQ *sharedInstance = nil;
+ (id)allocWithZone:(NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone];
        [sharedInstance initTencentOAuth];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleOpenURLNotification:)
                                                     name:@"RCTOpenURLNotification"
                                                   object:nil];
    });
    return sharedInstance;
}

+(instancetype)shareViewCtrl
{
    // 最好用self 用Tool他的子类调用时会出现错误
    return [[self alloc]init];
}
// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    return sharedInstance;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return sharedInstance;
}
- (NSArray<NSString *> *)supportedEvents {
    return @[];
}
- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

- (NSDictionary *)constantsToExport {
    return @{@"QQ": @(QQ),
             @"QQZone": @(QQZone),
             @"Favorite": @(Favorite),
             };
}
#pragma mark 监测是否安装QQ
RCT_EXPORT_METHOD(checkClientInstalled
                  :(RCTPromiseResolveBlock)resolve
                  :(RCTPromiseRejectBlock)reject) {
    if ([TencentOAuth iphoneQQInstalled] && [TencentOAuth iphoneQQSupportSSOLogin]) {
        resolve(@YES);
    } else {
        reject(@"404", QQ_NOT_INSTALLED, nil);
    }
}
#pragma mark 登录
RCT_EXPORT_METHOD(login
                  : (RCTPromiseResolveBlock)resolve
                  : (RCTPromiseRejectBlock)reject) {
    if (nil == tencentOAuth) {
        [self initTencentOAuth];
    }
    loginResolve = resolve;
    loginReject = reject;
    NSArray *permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            nil];
    [tencentOAuth setAuthShareType:AuthShareType_QQ];
    [tencentOAuth authorize:permissions];
}
#pragma mark 登出
RCT_EXPORT_METHOD(loginOut
                  :(RCTPromiseResolveBlock)resolve
                  :(RCTPromiseRejectBlock)reject) {
    logoutResolve = resolve;
    logoutReject = reject;
    [tencentOAuth logout: self];
}
#pragma mark 查看Token
RCT_EXPORT_METHOD(viewCachedToken:(RCTPromiseResolveBlock)resolve
                  :(RCTPromiseRejectBlock)reject){
    NSString *token = [tencentOAuth getCachedToken];
    NSString *openid = [tencentOAuth getCachedOpenID];
    NSDate *exp = [tencentOAuth getCachedExpirationDate];
    BOOL isValid = [tencentOAuth isCachedTokenValid];
    NSNumber *isValidNum = [NSNumber numberWithBool:isValid];
    if (token && openid && exp) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:token forKey:@"token"];
        [dic setObject:openid forKey:@"openid"];
//        [dic setObject:expTime forKey:@"exp"];
        [dic setObject:@(exp.timeIntervalSince1970*1000) forKey:@"exp"];
        [dic setObject:isValidNum forKey:@"isValid"];
        NSString *resultJson = [Tools convertToJsonData:dic];
        resolve(resultJson);
    }else{
//        wx-todo：错误码和抛出错误需要协定
        reject(@"404",@"没有token",nil);
    }
    
}
#pragma mark 删除Token
RCT_EXPORT_METHOD(deleteCachedToken
                  :(RCTPromiseResolveBlock)resolve
                  :(RCTPromiseRejectBlock)reject) {
    BOOL ret =  [tencentOAuth deleteCachedToken];
    NSNumber *retNum = [NSNumber numberWithBool:ret];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:retNum forKey:@"result"];
    NSString *resultJson =[Tools convertToJsonData:dic];
    resolve(resultJson);
}
#pragma mark 分享文本
RCT_EXPORT_METHOD(shareText:(NSString *)text
                  shareScene:(NSNumber *_Nonnull)scene
                  :(RCTPromiseResolveBlock)resolve
                  :(RCTPromiseRejectBlock)reject) {
    shareReject = reject;
    shareResolve = resolve;
    if (!text) {
        shareReject(@"404",@"没有token",nil);
    }else{
        [self shareObjectWithData:@{@"text":text} Type:TextMessage Scene:[[NSString stringWithFormat:@"%@",scene] integerValue]];
    }
}

#pragma mark 分享图片
/**
 分享图片
 image：本地图片地址，网路图片地址，base64目前解析有问题
 */
RCT_EXPORT_METHOD(shareImage:(NSString *)image
                  title:(NSString *)title
                  description:(NSString *)description
                  shareScene:(NSNumber *_Nonnull)scene
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    shareReject = reject;
    shareResolve = resolve;
    NSData *imageData = [self processImage:image];
    if(!imageData) {
        shareReject(@"500", QQ_IMAGE_PARAM_INCORRECT, nil);
    } else {
        [self shareObjectWithData:@{@"image":imageData,
                                    @"title":title,
                                    @"description":description}
                             Type:ImageMesssage
                            Scene:[[NSString stringWithFormat:@"%@",scene] integerValue]];
    }
}

#pragma mark 分享新闻
/**
 分享图片
 image：本地图片地址，网路图片地址，base64目前解析有问题
 */
RCT_EXPORT_METHOD(shareNews:(NSString *)url
                  image:(NSString *)image
                  title:(NSString *)title
                  description:(NSString *)description
                  shareScene:(NSNumber *_Nonnull)scene
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    shareReject = reject;
    shareResolve = resolve;
    NSData *imageData = [self processImage:image];
    if(!imageData) {
        shareReject(@"500", QQ_IMAGE_PARAM_INCORRECT, nil);
    } else {
        [self shareObjectWithData:@{@"url":url,
                                    @"image":imageData,
                                    @"title":title,
                                    @"description":description}
                             Type:NewsMessageWithLocalImage
                            Scene:[[NSString stringWithFormat:@"%@",scene] integerValue]];
    }
}
#pragma mark 分享音频
/**
 分享音频
 @param audioUrl 音频内容的目标URL（点击新闻进入的内容）
 @param flashUrl 外部点击播放按钮的流媒体url(远程url，不得使用本地文件)
 @param image 播放图片
 @param title 分享内容的标题
 @param description 分享内容的描述
 
 */
RCT_EXPORT_METHOD(shareAudio:(NSString *)audioUrl
                  flashUrl:(NSString *)flashUrl
                  image:(NSString *)image
                  title:(NSString *)title
                  description:(NSString *)description
                  shareScene:(NSNumber *_Nonnull)scene
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    shareReject = reject;
    shareResolve = resolve;
//    flashUrl = @"http://ra01.sycdn.kuwo.cn/resource/n3/32/56/3260586875.mp3";
    NSData *imageData = [self processImage:image];
    if (!imageData) {
        shareReject(@"500", QQ_IMAGE_PARAM_INCORRECT, nil);
    } else {
        [self shareObjectWithData:@{@"url":audioUrl,
                                    @"flashUrl":flashUrl,
                                    @"image":imageData,
                                    @"title":title,
                                    @"description":description}
                             Type:AudioMessage
                            Scene:[[NSString stringWithFormat:@"%@",scene] integerValue]];
    }
}
#pragma mark 分享视频
/**
 分享视频
 @param videoUrl 视频新闻内容的目标URL（点击新闻进入的内容）
 @param flashUrl 外部点击播放按钮的流媒体url(远程url，不得使用本地文件)
 @param image 播放图片
 @param title 分享内容的标题
 @param description 分享内容的描述
 
 */
RCT_EXPORT_METHOD(shareVideo:(NSString *)videoUrl
                  flashUrl:(NSString *)flashUrl
                  image:(NSString *)image
                  title:(NSString *)title
                  description:(NSString *)description
                  shareScene:(NSNumber *_Nonnull)scene
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    shareReject = reject;
    shareResolve = resolve;
    NSData *imageData = [self processImage:image];
    [self shareObjectWithData:@{@"url":videoUrl,
                                @"flashUrl":flashUrl,
                                @"image":imageData,
                                @"title":title,
                                @"description":description}
                         Type:VideoMessage
                        Scene:[[NSString stringWithFormat:@"%@",scene] integerValue]];
}

- (void)shareTextToQQZone:(NSString *)text {
    QQApiImageArrayForQZoneObject *txtObj = [QQApiImageArrayForQZoneObject objectWithimageDataArray:nil title:text extMap:nil];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
}

- (void)shareObjectWithData:(NSDictionary *)shareData Type:(QQShareType)type Scene:(QQShareScene)scene {
    switch (type) {
        case TextMessage: {
            NSString *msg = [shareData objectForKey:@"text"];
            QQApiTextObject *txtObj = [QQApiTextObject objectWithText:msg];
            [txtObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
            txtObj.shareDestType = ShareDestTypeQQ;
            switch (scene) {
                case QQZone:
                    [self shareTextToQQZone:msg];
                    return;
                case Favorite:
                    [txtObj setCflag:kQQAPICtrlFlagQQShareFavorites];
                    break;
                default:
                    [txtObj setCflag:kQQAPICtrlFlagQQShare];
                    break;
            }
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            [self handleSendResult:sent];
        } break;
        case ImageMesssage: {
            NSData *data = [shareData objectForKey:@"image"];
            NSString *title = [shareData objectForKey:@"title"];
            NSString *description = [shareData objectForKey:@"description"];
            QQApiImageObject *imgObj = [QQApiImageObject objectWithData:data
                                                       previewImageData:nil
                                                                  title:title
                                                            description:description];
            imgObj.shareDestType = ShareDestTypeQQ;
            switch (scene) {
                case QQZone:
                    [imgObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
                    break;
                case Favorite:
                    [imgObj setCflag:kQQAPICtrlFlagQQShareFavorites];
                    break;
                default:
                    [imgObj setCflag:kQQAPICtrlFlagQQShare];
                    break;
            }
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            [self handleSendResult:sent];
        } break;
        case NewsMessageWithLocalImage: {
            NSData *data = [shareData objectForKey:@"image"];
            NSURL *url = [NSURL URLWithString:[shareData objectForKey:@"url"]];
            NSString *title = [shareData objectForKey:@"title"];
            NSString *description = [shareData objectForKey:@"description"];
            QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:url
                                                                title:title
                                                          description:description
                                                     previewImageData:data];
            newsObj.shareDestType = ShareDestTypeQQ;
            switch (scene) {
                case QQZone:
                    [newsObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
                    break;
                case Favorite:
                    [newsObj setCflag:kQQAPICtrlFlagQQShareFavorites];
                    break;
                default:
                    [newsObj setCflag:kQQAPICtrlFlagQQShare];
                    break;
            }
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            [self handleSendResult:sent];
        } break;
        case AudioMessage: {
            NSData *data = [shareData objectForKey:@"image"];
            NSURL *url = [NSURL URLWithString:[shareData objectForKey:@"url"]];
            NSString *title = [shareData objectForKey:@"title"];
            NSString *description = [shareData objectForKey:@"description"];
            NSURL *flashUrl = [NSURL URLWithString:[shareData objectForKey:@"flashUrl"]];
            QQApiAudioObject *audioObj = [QQApiAudioObject objectWithURL:url
                                                                   title:title
                                                             description:description
                                                        previewImageData:data];
            [audioObj setFlashURL:flashUrl];
            audioObj.shareDestType = ShareDestTypeQQ;
            switch (scene) {
                case QQZone:
                    [audioObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
                    break;
                case Favorite:
                    [audioObj setCflag:kQQAPICtrlFlagQQShareFavorites];
                    break;
                default:
                    [audioObj setCflag:kQQAPICtrlFlagQQShare];
                    break;
            }
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:audioObj];
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            [self handleSendResult:sent];
        } break;
        case VideoMessage: {
            NSData *data = [shareData objectForKey:@"image"];
            NSURL *url = [NSURL URLWithString:[shareData objectForKey:@"url"]];
            NSString *title = [shareData objectForKey:@"title"];
            NSString *description = [shareData objectForKey:@"description"];
            NSURL *flashUrl = [NSURL URLWithString:[shareData objectForKey:@"flashUrl"]];
            QQApiVideoObject *videoObj = [QQApiVideoObject objectWithURL:url
                                                                   title:title
                                                             description:description
                                                        previewImageData:data];
            [videoObj setFlashURL:flashUrl];
            videoObj.shareDestType = ShareDestTypeQQ;
            switch (scene) {
                case QQZone:
                    [videoObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
                    break;
                case Favorite:
                    [videoObj setCflag:kQQAPICtrlFlagQQShareFavorites];
                    break;
                default:
                    [videoObj setCflag:kQQAPICtrlFlagQQShare];
                    break;
            }
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:videoObj];
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            [self handleSendResult:sent];
        }
        default:
            break;
    }
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult {
    switch (sendResult) {
        case EQQAPISENDSUCESS:
            break;
        case EQQAPIAPPSHAREASYNC:
            break;
        case EQQAPIAPPNOTREGISTED: {
            if (shareReject) {
                shareReject(@"500", @"App 未注册", nil);
                shareReject = nil;
                shareResolve = nil;
            }
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID: {
            if (shareReject) {
                shareReject(@"500", @"发送参数错误", nil);
                shareReject = nil;
                shareResolve = nil;
            }
            break;
        }
        case EQQAPITIMNOTINSTALLED: {
            if (shareReject) {
                shareReject(@"500", @"没有安装 TIM", nil);
                shareReject = nil;
                shareResolve = nil;
            }
            break;
        }
        case EQQAPIQQNOTINSTALLED: {
            if (shareReject) {
                shareReject(@"500", @"没有安装手机 QQ", nil);
                shareReject = nil;
                shareResolve = nil;
            }
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI: {
            if (shareReject) {
                shareReject(@"500", @"API 接口不支持", nil);
                shareReject = nil;
                shareResolve = nil;
            }
            break;
        }
        case EQQAPISENDFAILD: {
            if (shareReject) {
                shareReject(@"500", @"发送失败", nil);
                shareReject = nil;
                shareResolve = nil;
            }
            break;
        }
        case ETIMAPIVERSIONNEEDUPDATE: {
            if (shareReject) {
                shareReject(@"500", @"当前 TIM 版本太低", nil);
                shareReject = nil;
                shareResolve = nil;
            }
            break;
        }
        case EQQAPIVERSIONNEEDUPDATE: {
            if (shareReject) {
                shareReject(@"500", @"当前 QQ 版本太低", nil);
                shareReject = nil;
                shareResolve = nil;
            }
            break;
        }
        case EQQAPIQZONENOTSUPPORTTEXT: {
            if (shareReject) {
                shareReject(@"500", @"QQZone 不支持 QQApiTextObject 分享", nil);
                shareReject = nil;
                shareResolve = nil;
            }
            break;
        }
        case EQQAPIQZONENOTSUPPORTIMAGE: {
            if (shareReject) {
                shareReject(@"500", @"QQZone 不支持 QQApiImageObject 分享", nil);
                shareReject = nil;
                shareResolve = nil;
            }
            break;
        }
        case EQQAPISHAREDESTUNKNOWN: {
            if (shareReject) {
                shareReject(@"500", @"未指定分享到 QQ 或 TIM", nil);
                shareReject = nil;
                shareResolve = nil;
            }
            break;
        }
        default: {
            if (shareReject) {
                shareReject(@"500", @"发生其他错误", nil);
                shareReject = nil;
                shareResolve = nil;
            }
            break;
        }
    }
}
//- (NSDictionary *)makeResultWithUserId:(NSString *)userId
//                           accessToken:(NSString *)accessToken
//                        expirationDate:(NSDate *)expirationDate {
//    NSDictionary *result = @{ @"userid" : userId,
//                              @"access_token" : accessToken,
//                              @"expires_time" : [NSString stringWithFormat:@"%f", [expirationDate timeIntervalSince1970] * 1000] };
//    return result;
//}
- (void)handleOpenURLNotification:(NSNotification *)notification {
    NSURL *url = [NSURL URLWithString:[notification userInfo][@"url"]];
    NSString *schemaPrefix = [@"tencent" stringByAppendingString:appId];
    if ([url isKindOfClass:[NSURL class]] && [[url absoluteString] hasPrefix:[schemaPrefix stringByAppendingString:@"://response_from_qq"]]) {
        [QQApiInterface handleOpenURL:url delegate:self];
    } else {
        [TencentOAuth HandleOpenURL:url];
    }
}
- (void)initTencentOAuth {
    NSArray *urlTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    for (id type in urlTypes) {
        NSArray *urlSchemes = [type objectForKey:@"CFBundleURLSchemes"];
        for (id scheme in urlSchemes) {
            if ([scheme isKindOfClass:[NSString class]]) {
                NSString *value = (NSString *)scheme;
                if ([value hasPrefix:@"tencent"] && (nil == tencentOAuth)) {
                    appId = [value substringFromIndex:7];
                    tencentOAuth = [[TencentOAuth alloc] initWithAppId:appId andDelegate:self];
                    break;
                }
            }
        }
    }
}
#pragma mark - 图片处理
- (NSData *)processImage:(NSString *)image {
    if ([self isBase64Data:image]) {
        return [[NSData alloc] initWithBase64EncodedString:image options:0];
    } else if ([image hasPrefix:@"http://"] || [image hasPrefix:@"https://"]) {
        NSURL *url = [NSURL URLWithString:image];
        return [NSData dataWithContentsOfURL:url];
    } else {
        return [NSData dataWithContentsOfFile:image];
    }
}

- (BOOL)isBase64Data:(NSString *)data {
    data = [[data componentsSeparatedByCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]]
            componentsJoinedByString:@""];
    if ([data length] % 4 == 0) {
        static NSCharacterSet *invertedBase64CharacterSet = nil;
        if (invertedBase64CharacterSet == nil) {
            invertedBase64CharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="] invertedSet];
        }
        return [data rangeOfCharacterFromSet:invertedBase64CharacterSet options:NSLiteralSearch].location == NSNotFound;
    }
    return NO;
}

#pragma mark - QQApiInterfaceDelegate
- (void)onReq:(QQBaseReq *)req {
}

- (void)onResp:(QQBaseResp *)resp {
    switch ([resp.result integerValue]) {
        case 0: {
            if (shareReject) {
                shareResolve(@YES);
                shareResolve = nil;
                shareReject = nil;
            }
            break;
        }
        case -4: {
            if (shareReject) {
                shareReject(@"503", QQ_SHARE_CANCEL, nil);
                shareResolve = nil;
            }
            break;
        }
        default: {
            if (shareReject) {
                shareReject(@"500", QQ_OTHER_ERROR, nil);
                shareReject = nil;
                shareResolve = nil;
            }
            break;
        }
    }
}

- (void)isOnlineResponse:(NSDictionary *)response {
}

#pragma mark - TencentSessionDelegate
- (void)tencentDidLogin {
    if (tencentOAuth.accessToken && 0 != [tencentOAuth.accessToken length] && loginResolve) {
        NSMutableDictionary *result = [[NSMutableDictionary alloc]init];
        if (tencentOAuth.authMode == kAuthModeServerSideCode ) {
            [result setObject:[tencentOAuth passData] forKey:@"passData"];
            [result setObject:tencentOAuth.accessToken forKey:@"severCode"];
        }
        else
        {
            [result setObject:[tencentOAuth passData] forKey:@"passData"];
            [result setObject:tencentOAuth.accessToken forKey:@"clientToken"];
            [result setObject:tencentOAuth.openId forKey:@"openid"];
        }
        NSString *resultJson = [Tools convertToJsonData:result];
        loginResolve(resultJson);
        loginReject = nil;
    } else {
        if (loginReject) {
            loginReject(@"600", QQ_LOGIN_ERROR, nil);
            loginResolve = nil;
            logoutReject = nil;
        }
    }
}
- (void)tencentDidLogout {
    if (logoutResolve) {
        tencentOAuth = nil;
        logoutResolve(@YES);
        logoutReject = nil;
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (cancelled && loginReject) {
        loginReject(@"603", QQ_LOGIN_CANCEL, nil);
        loginResolve = nil;
        loginReject = nil;
    }
}

- (void)tencentDidNotNetWork {
    if (loginReject) {
        loginReject(@"600", QQ_LOGIN_NETWORK_ERROR, nil);
        loginResolve = nil;
        loginReject = nil;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    loginResolve = nil;
    loginReject = nil;
    logoutResolve = nil;
    logoutReject = nil;
    shareResolve = nil;
    shareReject = nil;
}

@end
