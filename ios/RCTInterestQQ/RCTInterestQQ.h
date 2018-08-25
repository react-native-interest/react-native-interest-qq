//
//  RCTInterestQQ.h
//  RCTInterestQQ
//
//  Created by Rabbit on 2018/8/25.
//  Copyright © 2018年 Rabbit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <React/RCTBridge.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTBridgeModule.h>

typedef NS_ENUM(NSInteger, QQShareScene) {
    QQ,
    QQZone,
    Favorite,
};

typedef NS_ENUM(NSInteger, QQShareType) {
    TextMessage,
    ImageMesssage,
    NewsMessageWithLocalImage,
    AudioMessage,
    VideoMessage,
};

@interface RCTInterestQQ : RCTEventEmitter <TencentSessionDelegate, QQApiInterfaceDelegate>

@end
