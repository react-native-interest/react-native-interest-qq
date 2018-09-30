# react-native-interest-qq

## 简介

本项目由react-native兴趣交流群开源并维护（群号：831849780）

目前基于QQ SDK（Android版本：xxx，iOS版本：V3.3.3）开发，为React Native开发者提供简单快捷的接入方式。我们将持续对该项目进行维护更新，如果有问题请在issues提出。

## 安装

不知道咋安装，npm吧或许

## 配置

### iOS配置

1. 添加依赖库 SystemConfiguration.framework 
2. 新增⼀条URL scheme:选中⼯工程Target -> Info -> URLTypes;新的scheme命名为: tencent+appid(ex: tencent123456) 
3. 添加⽩白名单:LSApplicationQueriesSchemes新增⽩白名单，详⻅见demo 
4. Appdelegate的handleOpenURL代理理⽅方法中中添加处理理回调的代码 

```
[QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[QQAp iShareEntry class]];
  if (YES == [TencentOAuth CanHandleOpenURL:url])
  {
return [TencentOAuth HandleOpenURL:url]; }
```

### Android配置

### React Native配置

引入react-native-interest-qq

```
import * as RNInterestQQ from "react-native-interest-qq"
```

## 功能列表

| 功能                     | iOS  | Android | React Naitve |
| :----------------------- | :--: | :--: | ------------ |
| [检查是否安装QQ](#1) | ✅ |    ✅   | isQQClientInstalled |
| [第三方登录](#2)               | ✅ |     ✅     | login |
| [第三方扫码登录](#3)           | ✅ |    ❌    | loginWithQRlogin |
| [退出账号](#4)                 | ✅ |     ✅    | logout |
| [查看缓存Token](#5)            | ✅ |     ❌     | viewCachedToken |
| [删除缓存](#6)                 | ✅ |     ❌     | deleteCachedToken |
| [分享文本消息](#7)             | ✅ |   ❌      | shareText |
| [分享图片（本地图片）](#8)     | ✅ |    ✅     | shareImage |
| [分享新闻（本地/网络图片）消息](#9) |  ✅   |    ✅    | shareNews                  |
| [分享音频消息](#10)                  |  ✅   |    ✅    | shareAudio                 |
| [分享视频消息](#11)                  |  ✅   |    ❌    | shareVideo                 |
| [分享文本+图片+链接](#12)   | ❌ |    ✅   | shareToQQ |
| [分享纯文本到QZone](#13)             |  ✅   |    ✅    | shareTextToQZone           |
| [分享新闻到QZone](#14)               |  ✅   |    ✅    | shareNewsToQzone           |
| [分享图片到QZone](#15)               |  ✅   |    ✅    | shareImgToQZone            |
| [分享音频到QZone](#16) | ✅ |   ✅      | shareAudioToQzone |
| [分享视频到QZone](#17)          | ✅ |     ✅    | shareVideoToQZone |
| [分享内容到QZone](#18)               |  ❌   |    ✅    | shareToQzone               |
| [分享文件（数据线）](#19)            |  ✅   |    ❌    | shareFile                  |
| [添加好友](#20)                      |  ✅   |    ❌    | addFriend                  |
| [获取UnionId](#21)  | ✅ |     ✅     | requestUnionId |
| [一键加群](#22) | ✅ | ❌ | joinGroup |
| [游戏绑定公会群](#23) | ✅ | ❌ | gameConsortiumBindingGroup |
<h4 id="1">检查是否安装QQ</h4>

检查改手机中是否安装了QQ

```react
RNInterestQQ.isQQClientInstalled()
	    .then(() => {
             })
	    .catch(() => {
	     })
```

<h4 id="2">第三方登录</h4>

使用QQ登录功能

```react
RNInterestQQ.login()
	    .then(() => {
	     })
	    .catch(() => {
	     })
```

<h4 id="3">第三方扫码登录  （仅iOS）</h4>

生成一个二维码以供扫码登录，仅支持iOS版本

```
RNInterestQQ.loginWithQRlogin()
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="4">退出账号</h4>

退出登录
```
RNInterestQQ.logout()
	    .then(() => {
	     })
            .catch(() => {
	     })
```
<h4 id="5">查看缓存Token（仅iOS）</h4>

```
RNInterestQQ.viewCachedToken()
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="6">删除缓存Token（仅iOS）</h4>

```
RNInterestQQ.deleteCachedToken()
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="7">分享文本消息（仅iOS）</h4>

分享一个文本到qq
```
RNInterestQQ.shareText('你需要分享的文字')
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="8">分享图片（本地图片）</h4>

分享一个文本到qq
```
 @param image 图片，可以是本地的，也可以上网上的
 @param title 分享标题
 @param description 分享摘要

RNInterestQQ.shareImage(image,title,description)
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="9">分享新闻（本地/网络图片）消息</h4>

分享新闻到qq
```
 @param url 要分享的url
 @param image 分享的图片，可以是远程的也可以是本地的
 @param title 分享标题
 @param description 分享摘要

RNInterestQQ.shareNews(url,image,title,description)
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="10">分享音频消息</h4>

分享音频到qq
```
@param url 要分享的url
@param flashUrl 要分享的播放文件的url
@param image 分享的图片，可以是远程的也可以是本地的 
@param title 分享标题
@param description 分享摘要

RNInterestQQ.shareAudio(url,flashUrl,image,title,description)
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="11">分享视频消息（仅iOS）</h4>

分享音频到qq
```
@param url 要分享的url
@param flashUrl 要分享的播放文件的url
@param image 分享的图片，可以是远程的也可以是本地的 
@param title 分享标题
@param description 分享摘要

RNInterestQQ.shareVideo(url,flashUrl,image,title,description)
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="12">分享到QQ（仅Android）</h4>

分享到qq
```
@param title 标题
@param desc 摘要
@param url 分享链接
@param imgUrl 分享的图片链接
@param appName 分享的app名称

RNInterestQQ.shareToQQ(title,desc,url,imgUrl,appName)
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="13">分享纯文本到QZone</h4>

```
@param text 要分享的文本

RNInterestQQ.shareTextToQzone(text)
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="14">分享新闻到QZone</h4>

```
@param url 要分享的url
@param image 分享的图片，可以是远程的也可以是本地的
@param title 分享标题
@param description 分享摘要

RNInterestQQ.shareNewsToQzone(url,image,title,description)
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="15">分享图片到qq空间</h4>

```
@param image 图片，可以是本地的，也可以上网上的
@param title 分享标题
@param description 分享摘要

RNInterestQQ.shareImgToQZone(image,title,description)
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="16">分享音频到qq空间</h4>

```
@param url 要分享的url
@param flashUrl 要分享的播放文件的url
@param image 分享的图片，可以是远程的也可以是本地的
@param title 分享标题
@param description 分享摘要

RNInterestQQ.shareAudioToQzone(url,flashUrl,image,title,description)
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="17">分享视频到qq空间</h4>

```
@param url 要分享的url
@param flashUrl 要分享的播放文件的url
@param image 分享的图片，可以是远程的也可以是本地的
@param title 分享标题
@param description 分享摘要

RNInterestQQ.shareVideoToQzone(url,flashUrl,image,title,description)
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="18">分享到qq空间（仅Android）</h4>

```
@param title 标题
@param desc 摘要
@param url 分享链接
@param imgUrlArr 图片列表

RNInterestQQ.shareToQzone(title,desc,url,imgUrlArr)
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="19">分享文件（数据线）（仅iOS）</h4>

```
@param fileUrl 文件路径

RNInterestQQ.shareFile(fileUrl)
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="20">添加好友（仅iOS）</h4>

```
RNInterestQQ.addFriend()
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="20">获取UnionId</h4>

```
RNInterestQQ.requestUnionId()
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="21">一键加群（仅iOS）</h4>

```
RNInterestQQ.joinGroup()
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
<h4 id="22">游戏绑定公会群（仅iOS）</h4>

```
RNInterestQQ.gameConsortiumBindingGroup()
	    .then(() => {
	     })
	    .catch(() => {
	     })
```
