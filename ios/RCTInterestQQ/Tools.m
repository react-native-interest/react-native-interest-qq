//
//  Tools.m
//  RCTInterestQQ
//
//  Created by 吴兴 on 2018/9/3.
//  Copyright © 2018年 Rabbit. All rights reserved.
//

#import "Tools.h"

@implementation Tools

#pragma mark - 字典转json
+ (NSString *)convertToJsonData:(NSDictionary *)dict{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}

#pragma mark -- JSON转字典
+ (NSDictionary *)jsonToDic:(NSString *)jsonString {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
}

#pragma mark -- 去除RN存储数据解析后的字符串含有 " 和 转义符
+ (NSString *)removeEscapeCharacter:(NSString*)string{
    //  首先自己定义一个NSCharacterSet, 包含需要去除的特殊符号
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    
    NSString *responseString = [string stringByTrimmingCharactersInSet:set];
    
    return responseString;
}

@end
