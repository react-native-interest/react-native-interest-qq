//
//  Tools.h
//  RCTInterestQQ
//
//  Created by 吴兴 on 2018/9/3.
//  Copyright © 2018年 Rabbit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject
#pragma mark - 字典转json
+ (NSString *)convertToJsonData:(NSDictionary *)dict;
#pragma mark -- JSON转字典
+ (NSDictionary *)jsonToDic:(NSString *)jsonString;
#pragma mark -- 去除RN存储数据解析后的字符串含有 " 和 转义符
+ (NSString *)removeEscapeCharacter:(NSString*)string;
@end
