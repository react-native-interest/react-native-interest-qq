# react-native-interest-qq

## react-native-qqsdk已实现的方法

1. 检查是否安装QQ => `checkClientInstalled`
2. 登录=> `ssoLogin`（官方sdk中，包括了QQ，TIM，网页端登录，二维码登录）
3. 退出登录  => `logout`
4. 分享到哪里，qqsdk中提供了，QQ，QQ空间，收藏 => `shareScene`
5. 分享文字 + 分享场景  => `shareText + shareScene`
6. 分享图片 + 文字 + 描述 + 分享场景 => `shareImage + title + description + shareScene`
7. 分享新闻 + 图片 + 文字 + 描述 + 分享场景 => `shareNews + image + title + description + shareScene`
8. 分享音频介绍页 + 音频地址 + 图片 + 文字 + 描述 + 分享场景 => `shareAudio + flashUrl + image + title + description + shareScene`
9. 分享视频介绍页 + 视频地址 + 图片 + 图片类型 + 文字 + 描述 + 分享场景 => `shareVideo + flashUrl + image + imageType + title + description + shareScene`
