'use strict'
import {
  NativeModules, 
  NativeEventEmitter,
	Platform

} from 'react-native';

const isIOS = Platform.OS==="ios";

const {QQSDK} =  NativeModules;

const PLATFORM_DOES_NOT_METHOD = "Platform does not method.";

/**
 * 检测是否安装了qq
 * @return 返回一个promise
 * */
export const isQQClientInstalled = QQSDK.checkClientInstalled;

/**
 * 调起qq登录
 * @return 返回一个promise
 * @return userid
 * @return access_token
 * @return expires_time
 * */
export const login = QQSDK.ssoLogin;

/**
 * 退出qq登录
 */
export const logout = QQSDK.logout;

export const shareScene = {'QQ': QQSDK.QQ, 'QQZone': QQSDK.QQZone, 'Favorite': QQSDK.Favorite};

/**
 * 分享一个文本到qq
 * @platform android
 * @param text 要分享的文本
 * @return 返回一个promise
 * */
export function shareText(text) {
    return QQSDK.shareText(text,shareScene.QQ);
}

/**
 * 分享一个文本到qq空间
 * @param text 要分享的文本
 * @return 返回一个promise
 * */
export function shareTextToQzone(text) {
    return QQSDK.shareText(text,shareScene.QQZone);
}

/**
 * 使用二维码登录
 * @platform ios
 * @return 返回一个promise
 * */
export function loginWithQRlogin() {
    if(isIOS){
        return QQSDK.loginWithQRlogin();
    }else{
        return Promise.reject({
            code:405,
            message:PLATFORM_DOES_NOT_METHOD
        })
    }
}

/**
 * 查看缓存Token
 * @platform ios
 * @return 返回一个promise
 * */
export function viewCachedToken() {
    if(isIOS){
        return QQSDK.viewCachedToken();
    }else{
        return Promise.reject({
            code:405,
            message:PLATFORM_DOES_NOT_METHOD
        })
    }
}


/**
 * 删除缓存Token
 * @platform ios
 * @return 返回一个promise
 * */
export function deleteCachedToken() {
    if(isIOS){
        return QQSDK.deleteCachedToken();
    }else{
        return Promise.reject({
            code:405,
            message:PLATFORM_DOES_NOT_METHOD
        })
    }
}

/**
 * 分享图片到qq
 * @param image 图片，可以是本地的，也可以上网上的
 * @param title 分享标题
 * @param description 分享摘要
 * */
export function shareImage(image,title="",description="") {
    return QQSDK.shareImage(image,title,description,shareScene.QQ)
}

/**
 * 分享图片到qq空间
 * @param image 图片，可以是本地的，也可以上网上的
 * @param title 分享标题
 * @param description 分享摘要
 * */
export function shareImgToQZone(image,title="",description="") {
    return QQSDK.shareImage(image,title,description,shareScene.QQZone)
}

/**
 * 分享新闻到qq
 * @param url 要分享的url
 * @param image 分享的图片，可以是远程的也可以是本地的
 * @param title 分享标题
 * @param description 分享摘要
 * */
export function shareNews(url,image,title,description="") {
    return QQSDK.shareImage(url,image,title,description,shareScene.QQ)
}


/**
 * 分享新闻到qq空间
 * @param url 要分享的url
 * @param image 分享的图片，可以是远程的也可以是本地的
 * @param title 分享标题
 * @param description 分享摘要
 * */
export function shareNewsToQzone(url,image,title,description="") {
    return QQSDK.shareImage(url,image,title,description,shareScene.QQZone)
}

/**
 * 分享音频到qq
 * @param url 要分享的url
 * @param flashUrl 要分享的播放文件的url
 * @param image 分享的图片，可以是远程的也可以是本地的
 * @param title 分享标题
 * @param description 分享摘要
 * */
export function shareAudio(url,flashUrl,image,title,description="") {
    return QQSDK.shareAudio(url,flashUrl,image,title,description,shareScene.QQ)
}

/**
 * 分享音频到qq空间
 * @param url 要分享的url
 * @param flashUrl 要分享的播放文件的url
 * @param image 分享的图片，可以是远程的也可以是本地的
 * @param title 分享标题
 * @param description 分享摘要
 * */
export function shareAudioToQzone(url,flashUrl,image,title,description="") {
    return QQSDK.shareAudio(url,flashUrl,image,title,description,shareScene.QQZone)
}


/**
 * 分享视频到qq
 * @platform ios
 * @param url 要分享的url
 * @param flashUrl 要分享的播放文件的url
 * @param image 分享的图片，可以是远程的也可以是本地的
 * @param title 分享标题
 * @param description 分享摘要
 * */
export function shareVideo(url,flashUrl,image,title,description="") {
    return QQSDK.shareVideo(url,flashUrl,image,title,description,shareScene.QQ)
}

/**
 * 分享视频到qq空间
 * @param url 要分享的url
 * @param flashUrl 要分享的播放文件的url
 * @param image 分享的图片，可以是远程的也可以是本地的
 * @param title 分享标题
 * @param description 分享摘要
 * */
export function shareVideoToQzone(url,flashUrl,image,title,description="") {
    return QQSDK.shareVideo(url,flashUrl,image,title,description,shareScene.QQZone)
}

/**
 * 分享文件（数据线）
 * @platform ios
 * @param fileUrl 文件路径
 * */
export function shareFile(fileUrl) {
    if(isIOS){
        return QQSDK.shareFile(fileUrl);
    }else{
        return Promise.reject({
            code:405,
            message:PLATFORM_DOES_NOT_METHOD
        })
    }
}

/**
 * 添加好友
 * @platform ios
 * */
export function addFriend() {
    if(isIOS){
        return QQSDK.addFriend();
    }else{
        return Promise.reject({
            code:405,
            message:PLATFORM_DOES_NOT_METHOD
        })
    }
}

/**
 * 获取UnionId
 * */
export function requestUnionId() {
        return QQSDK.requestUnionId();
}

/**
 * 一件加群
 * @platform ios
 *
 * */
export function joinGroup() {
    if(isIOS){
        return QQSDK.joinGroup();
    }else{
        return Promise.reject({
            code:405,
            message:PLATFORM_DOES_NOT_METHOD
        })
    }
}

/**
 * 游戏绑定公会群
 * @platform ios
 * */
export function gameConsortiumBindingGroup() {
    if(isIOS){
        return QQSDK.gameConsortiumBindingGroup();
    }else{
        return Promise.reject({
            code:405,
            message:PLATFORM_DOES_NOT_METHOD
        })
    }
}

/**
 * 分享内容到qq
 * @platform android
 * @param title 标题
 * @param desc 摘要
 * @param url 分享链接
 * @param imgUrl 分享的图片链接
 * @param appName 分享的app名称
 * */
export function shareToQQ(title,desc="",url,imgUrl,appName) {
    if(!isIOS){
        return QQSDK.shareToQQ(title,desc,url,image,appName);
    }else{
        return Promise.reject({
            code:405,
            message:PLATFORM_DOES_NOT_METHOD
        })
    }
}

/**
 * 分享内容到qq空间
 * @platform android
 * @param title 标题
 * @param desc 摘要
 * @param url 分享链接
 * @param imgUrlArr 图片列表
 * */
export function shareToQzone(title,desc="",url,imgUrlArr) {
    if(!isIOS){
        return QQSDK.shareToQzone(title,desc,url,imgUrlArr);
    }else{
        return Promise.reject({
            code:405,
            message:PLATFORM_DOES_NOT_METHOD
        })
    }
}